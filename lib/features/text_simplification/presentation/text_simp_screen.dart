import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'text_simp_notifier.dart';

class TextSimplificationScreen extends HookConsumerWidget {
  const TextSimplificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TextEditingController 를 Hook을 통해 생성 (자동 dispose 처리)
    final textController = useTextEditingController();
    // 텍스트 변환 상태 구독
    final state = ref.watch(textSimplificationNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('텍스트 쉬운말 변환')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 입력 텍스트 필드
            TextField(
              controller: textController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '어려운 표현의 문장을 입력하세요',
              ),
            ),
            const SizedBox(height: 12),
            // 변환 버튼
            ElevatedButton(
              onPressed:
                  state.isLoading
                      ? null // 로딩 중에는 버튼 비활성화
                      : () {
                        // Notifier의 simplify 메서드 호출
                        ref
                            .read(textSimplificationNotifierProvider.notifier)
                            .simplify(textController.text);
                      },
              child:
                  state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('쉬운말로 변환'),
            ),
            const SizedBox(height: 20),
            // 결과 또는 로딩/에러 표시
            if (state.isLoading) ...[
              const CircularProgressIndicator(),
            ] else if (state.error != null) ...[
              Text(state.error!, style: const TextStyle(color: Colors.red)),
            ] else if (state.result != null) ...[
              Text(
                '변환 결과: ${state.result!}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
