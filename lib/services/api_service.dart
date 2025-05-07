import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainArrival {
  final String trainLine; // 열차 노선 및 행선지 (예: "2호선 성수행")
  final String arrivalMessage; // 열차 도착 안내 메시지 (예: "곧 도착", "전역 출발")

  TrainArrival({required this.trainLine, required this.arrivalMessage});
}

class SubwayAPI {
  static const String _apiKey =
      '4b4f744944616b733534686f644b64'; // 실제 발급받은 서울시 API 키로 교체
  static const String _baseUrl = 'http://swopenapi.seoul.go.kr/api/subway';

  /// 서울시 지하철 실시간 도착정보 API 호출 함수
  /// [stationName]으로 전달된 역의 실시간 열차 도착 정보를 가져옵니다.
  static Future<List<TrainArrival>> fetchSubwayPositions(
    String stationName,
  ) async {
    // 역 이름을 URL에 포함하기 위해 인코딩
    final encodedStation = Uri.encodeComponent(stationName);
    final url =
        '$_baseUrl/$_apiKey/json/realtimeStationArrival/0/5/$encodedStation';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        // HTTP 200 성공 -> JSON 파싱
        final data = json.decode(response.body);
        // 응답 내 errorMessage 필드 확인 (정상일 경우 status == 200)
        if (data['errorMessage'] != null &&
            data['errorMessage']['status'] != 200) {
          // API에서 오류를 응답한 경우 (예: 잘못된 역 이름 등)
          throw Exception('API error: ${data['errorMessage']['message']}');
        }
        // 'realtimeArrivalList' 배열에 열차 도착 정보들이 포함됨
        final List arrivals = data['realtimeArrivalList'] ?? [];
        // 각 열차 정보 객체를 TrainArrival 모델로 변환
        List<TrainArrival> results =
            arrivals.map((item) {
              String line = item['trainLineNm'] ?? '알 수 없음'; // 노선/행선지 정보
              String arrive = item['arvlMsg2'] ?? '정보 없음'; // 도착 안내 메세지
              return TrainArrival(trainLine: line, arrivalMessage: arrive);
            }).toList();
        return results;
      } else {
        // 200이 아닌 HTTP 응답 코드는 오류로 처리
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      // 예외 발생: 네트워크 오류 또는 JSON 파싱 오류 등
      print('Error fetching subway data: $e');
      rethrow; // 오류를 상위 호출부에 전달하여 처리
    }
  }
}
