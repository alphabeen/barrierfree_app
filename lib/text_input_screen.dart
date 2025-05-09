import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/translation_provider.dart';
import 'ocr_screen.dart';

class TextInputScreen extends ConsumerWidget {
  const TextInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final state = ref.watch(translationProvider); //상태를 감시

    return Scaffold(
      appBar: AppBar(title: const Text('The쉬운말로')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '텍스트 입력',
                hintText: '변환할 텍스트를 입력하세요',
              ),
              maxLines: null,
            ),

            // 사용자가 변환할 문장을 입력하는 필드, 여러 줄 입력 가능
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                ref
                    .read(translationProvider.notifier)
                    .simplify(controller.text);
                // 변환 버튼 누르면 상태 갱신
                await Future.delayed(const Duration(milliseconds: 600));
                // 0.6초 대기 후 결과 화면으로 이동
                final result = ref.read(translationProvider).value;
                if (result != null) {
                  Navigator.pushNamed(context, '/result', arguments: result);
                }
                //결과 존재 -> 결과 화면으로 이동, 없으면 아무것도 안함
              },
              child: const Text('쉬운 말로 변환'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ocr');
              },
              child: const Text('OCR로 입력'),
            ),
            // OCR 화면 이동
            const SizedBox(height: 16),
            if (state.isLoading) const CircularProgressIndicator(),
            if (state.hasError) const Text('오류가 발생했습니다'),
          ],
          // 변환 중이면 로딩 스피너, 오류 발생 시 텍스트로 오류 메세지지
        ),
      ),
    );
  }
}
