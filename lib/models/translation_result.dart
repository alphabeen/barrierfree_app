// 원래 문장과 쉽게 바꾼 문장을 담는 모델 클래스
class TranslationResult {
  final String original; // 원래 문장
  final String simplified; // 쉽게 바꾼 문장
  TranslationResult({required this.original, required this.simplified});
}
