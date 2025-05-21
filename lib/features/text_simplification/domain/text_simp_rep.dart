abstract class TextSimplificationRepository {
  /// 주어진 입력 텍스트를 쉬운 표현으로 변환한다.
  Future<String> simplifyText(String input);
}
