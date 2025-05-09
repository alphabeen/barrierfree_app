import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/translation_result.dart';
import '../services/dummy_text_service.dart';

// 상태: AsyncValue<TranslationResult> , 로딩 성공 실패 상태 구분할 수 있는 구조
final translationProvider =
    StateNotifierProvider<TranslationNotifier, AsyncValue<TranslationResult>>(
      (ref) => TranslationNotifier(),
    );

class TranslationNotifier extends StateNotifier<AsyncValue<TranslationResult>> {
  TranslationNotifier()
    : super(AsyncValue.data(TranslationResult(original: '', simplified: '')));
  // 초기값은 빈 TranslationResult 객체, 실제 상태 변경해주는 클래스
  Future<void> simplify(String input) async {
    state = const AsyncValue.loading();
    // 상태를 로딩으로 변경
    try {
      final result = await TextSimplifyService.simplifyText(input);
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
