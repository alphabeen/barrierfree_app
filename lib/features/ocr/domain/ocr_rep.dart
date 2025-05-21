import 'dart:io';

abstract class OcrRepository {
  /// 주어진 이미지 파일에서 텍스트를 추출한다.
  Future<String> extractTextFromImage(File imageFile);
}
