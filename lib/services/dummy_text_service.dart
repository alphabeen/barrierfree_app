import '../models/translation_result.dart';

class TextSimplifyService {
  /// 실제 앱에서는 외부 API호출, 여기서는 더미.
  static Future<TranslationResult> simplifyText(String input) async {
    // API 호출을 시뮬레이션 하기 위해 500ms 대기.
    await Future.delayed(const Duration(milliseconds: 500));
    String simplified;
    if (input.trim().isEmpty) {
      // 지금은 더미 변환환
      simplified = '';
    } else {
      // 더미 변환 로직 : 입력된 텍스트에 "(쉬운 말로 변환됨)" 추가
      simplified = '$input (쉬운 말로 변환됨)';
    }
    // TranslationResult라는 객체로 감싸서 반환
    return TranslationResult(original: input, simplified: simplified);
  }
}
