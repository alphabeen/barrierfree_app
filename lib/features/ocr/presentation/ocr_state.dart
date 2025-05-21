import 'dart:io';

class OcrState {
  final File? imageFile; // 선택된 이미지 파일
  final String? extractedText; // 추출된 텍스트 결과
  final bool isLoading; // OCR 처리 중인지 여부
  final String? error; // 오류 메시지

  OcrState({
    this.imageFile,
    this.extractedText,
    this.isLoading = false,
    this.error,
  });

  // copyWith 구현으로 불변 상태 관리
  OcrState copyWith({
    File? imageFile,
    String? extractedText,
    bool? isLoading,
    String? error,
  }) {
    return OcrState(
      imageFile: imageFile ?? this.imageFile,
      extractedText: extractedText ?? this.extractedText,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
