// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

/// 도착 정보 모델 클래스
class TrainArrival {
  final String trainLine; // 예: "성수행 - 강남방면"
  final String arrivalMessage; // 예: "전역 출발", "곧 도착"

  TrainArrival({required this.trainLine, required this.arrivalMessage});

  factory TrainArrival.fromJson(Map<String, dynamic> json) {
    return TrainArrival(
      trainLine: json['trainLineNm'] ?? '',
      arrivalMessage: json['arvlMsg2'] ?? '',
    );
  }
}

class SubwayAPI {
  static const _apiKey = '4441747a6c6f697531303031736e724a'; // 샘플키
  static const _baseUrl = 'http://swopenapi.seoul.go.kr/api/subway';

  /// 강남역 기준 전체 열차 정보 가져오기
  static Future<List<TrainArrival>> fetchSubwayPositions(
    String stationName,
  ) async {
    final url =
        '$_baseUrl/$_apiKey/json/realtimeStationArrival/0/30/$stationName';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      final List arrivals = decoded['realtimeArrivalList'] ?? [];

      return arrivals.map((item) => TrainArrival.fromJson(item)).toList();
    } else {
      throw Exception('API 호출 실패: ${response.statusCode}');
    }
  }

  /// 출발역 및 도착역 기준 필터링된 열차 정보 가져오기
  static Future<List<TrainArrival>> fetchFilteredSubwayPositions({
    required String stationName,
    required String origin,
    required String destination,
  }) async {
    final allArrivals = await fetchSubwayPositions(stationName);

    return allArrivals.where((arrival) {
      final line = arrival.trainLine.replaceAll(' ', '');
      return line.contains(origin.replaceAll(' ', '')) &&
          line.contains(destination.replaceAll(' ', ''));
    }).toList();
  }
}
