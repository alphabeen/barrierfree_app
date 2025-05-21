import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../text_simplification/domain/text_simp_rep.dart';
import 'text_simp_state.dart';
import '../../text_simplification/data/text_simp_rep_impl.dart';

// StateNotifierProvider를 통해 사용할 Notifier
class TextSimplificationNotifier
    extends StateNotifier<TextSimplificationState> {
  final TextSimplificationRepository _repository;

  TextSimplificationNotifier(this._repository)
    : super(TextSimplificationState()); // 초기 상태 설정

  /// 입력된 텍스트를 쉬운말로 변환 요청
  Future<void> simplify(String input) async {
    // 입력이 비어있으면 에러 상태 설정
    if (input.trim().isEmpty) {
      state = state.copyWith(
        result: null,
        error: '텍스트를 입력해주세요.',
        isLoading: false,
      );
      return;
    }
    // 로딩 상태로 전환 (이전 결과/에러는 초기화)
    state = state.copyWith(result: null, error: null, isLoading: true);
    try {
      // 레포지토리 호출하여 변환된 텍스트 얻기
      final simplifiedText = await _repository.simplifyText(input);
      // 성공 상태 업데이트 (결과 표시, 로딩 해제)
      state = state.copyWith(
        result: simplifiedText,
        error: null,
        isLoading: false,
      );
    } catch (e) {
      // 에러 발생 시 에러 상태 업데이트
      state = state.copyWith(
        result: null,
        error: '변환에 실패했습니다: $e',
        isLoading: false,
      );
    }
  }
}

// Repository 구현체를 주입하기 위한 Provider (의존성 주입)
final textSimplificationRepositoryProvider =
    Provider<TextSimplificationRepository>(
      (ref) => TextSimplificationRepositoryImpl(),
    );

// TextSimplificationNotifier의 Provider (UI에서는 이 provider를 구독)
final textSimplificationNotifierProvider =
    StateNotifierProvider<TextSimplificationNotifier, TextSimplificationState>((
      ref,
    ) {
      final repo = ref.watch(textSimplificationRepositoryProvider);
      return TextSimplificationNotifier(repo);
    });
