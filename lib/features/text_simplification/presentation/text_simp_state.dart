class TextSimplificationState {
  final String? result; // 변환된 쉬운말 결과
  final bool isLoading; // 로딩 중 상태
  final String? error; // 오류 메시지 (있다면)

  TextSimplificationState({this.result, this.isLoading = false, this.error});

  // 상태 복사를 위한 copyWith (불변 객체 패턴 유지)
  TextSimplificationState copyWith({
    String? result,
    bool? isLoading,
    String? error,
  }) {
    return TextSimplificationState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
