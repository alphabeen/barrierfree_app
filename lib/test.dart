import 'package:flutter/material.dart';
import 'services/api_test.dart'; // API 서비스 모듈 가져오기

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
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18.0),
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
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
  List<TrainArrival> _arrivals = [];
  bool _isLoading = false;
  String? _errorMessage;

  // ✅ 출발/도착역 텍스트 필드 컨트롤러
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  Future<void> _getTrainInfo() async {
    final departure = _departureController.text.trim();
    final destination = _destinationController.text.trim();

    if (departure.isEmpty || destination.isEmpty) {
      setState(() => _errorMessage = '출발역과 도착역을 모두 입력하세요.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      List<TrainArrival> data = await SubwayAPI.fetchFilteredSubwayPositions(
        stationName: departure,
        origin: departure,
        destination: destination,
      );
      setState(() {
        _arrivals = data;
      });
    } catch (e) {
      setState(() => _errorMessage = '열차 정보를 불러오지 못했습니다. 다시 시도해주세요.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('실시간 열차 정보')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _departureController,
              decoration: const InputDecoration(
                labelText: '출발역',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: '도착역',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _getTrainInfo,
              child: const Text('지하철 위치 확인', style: TextStyle(fontSize: 18.0)),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (!_isLoading && _errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            if (!_isLoading && _errorMessage == null)
              Expanded(
                child: ListView.builder(
                  itemCount: _arrivals.length,
                  itemBuilder: (context, index) {
                    final arrival = _arrivals[index];
                    return ListTile(
                      title: Text(
                        arrival.trainLine,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        arrival.arrivalMessage,
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
삼성