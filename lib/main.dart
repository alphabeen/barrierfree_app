import 'package:flutter/material.dart';
import 'services/api_service.dart'; // API 서비스 모듈 가져오기

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '조용한 지하철',
      theme: ThemeData(
        // 접근성을 고려한 테마: 기본 폰트 크기를 크게 설정
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18.0), // 일반 본문 글씨 크게
          titleLarge: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ), // 제목 글씨 크게
        ),
        // 기본 색상 등을 설정 가능. 고대비 테마나 색약자를 위한 색상 조합 고려.
      ),
      home: const SubwayHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SubwayHomePage extends StatefulWidget {
  const SubwayHomePage({super.key});

  @override
  State<SubwayHomePage> createState() => _SubwayHomePageState();
}

class _SubwayHomePageState extends State<SubwayHomePage> {
  // 지하철 도착 정보 리스트 및 상태 표시 변수들
  List<TrainArrival> _arrivals = []; // 도착 정보 목록
  bool _isLoading = false; // 로딩 상태 여부
  String? _errorMessage; // 오류 발생 시 메세지

  /// 실시간 열차 정보를 조회하는 함수
  Future<void> _getTrainInfo() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      // 예시: '강남' 역의 실시간 도착 정보를 가져옵니다.
      List<TrainArrival> data = await SubwayAPI.fetchSubwayPositions('강남');
      setState(() {
        _arrivals = data;
      });
      // 접근성 피드백: 진동 및 음성 안내 (필요 시 패키지 추가하여 사용)
      if (data.isNotEmpty) {
        // 예: 진동으로 알림 (vibration 패키지 필요)
        // Vibration.vibrate(duration: 500);
        // 예: TTS로 첫 번째 도착 정보 안내 (flutter_tts 패키지 필요)
        // FlutterTts flutterTts = FlutterTts();
        // await flutterTts.speak('${data[0].trainLine} 열차 정보가 업데이트되었습니다.');
      }
    } catch (e) {
      // 오류 발생 시 메시지 설정
      setState(() {
        _errorMessage = '열차 정보를 불러오지 못했습니다. 다시 시도해주세요.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('실시간 열차 정보')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 콘텐츠 주위에 여백을 주어 가독성 향상
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // [조회 버튼] 실시간 정보 조회 트리거
            ElevatedButton(
              onPressed: _isLoading ? null : _getTrainInfo, // 로딩 중일 때는 버튼 비활성화
              child: const Text(
                '지하철 위치 확인',
                style: TextStyle(fontSize: 18.0), // 큰 버튼 텍스트
              ),
            ),
            const SizedBox(height: 20),
            // [로딩 중] 프로그레스 인디케이터
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            // [오류 메시지] 오류가 발생한 경우 화면에 표시
            if (!_isLoading && _errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            // [결과 리스트] API로부터 받은 열차 도착 정보 목록 표시
            if (!_isLoading && _errorMessage == null)
              Expanded(
                child: ListView.builder(
                  itemCount: _arrivals.length,
                  itemBuilder: (context, index) {
                    final arrival = _arrivals[index];
                    return ListTile(
                      title: Text(
                        arrival.trainLine, // 열차 노선 및 행선지 (예: "2호선 성수행")
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        arrival.arrivalMessage, // 도착 안내 메시지 (예: "곧 도착")
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
