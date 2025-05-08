import 'package:flutter/material.dart';
import 'services/dummy_text_service.dart';
import 'models/translation_result.dart';

class TextInputScreen extends StatefulWidget {
  const TextInputScreen({Key? key}) : super(key: key);

  @override
  _TextInputScreenState createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('The쉬운말로')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 사용자에게 문장을 입력받는 텍스트 필드
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '텍스트 입력',
                hintText: '변환할 텍스트를 입력하세요',
              ),
              maxLines: null, // 여러 줄의 입력 허용
            ),
            const SizedBox(height: 16),
            // 버튼을 눌러 변환 요청
            ElevatedButton(
              onPressed: () async {
                final inputText = _controller.text;
                // API 호출을 통해 변환된 결과를 가져옴 (지금은 더미변환)
                TranslationResult result =
                    await TextSimplifyService.simplifyText(inputText);
                // 결과 화면으로 이동
                Navigator.pushNamed(context, '/result', arguments: result);
              },
              child: const Text('쉬운 말로 변환'),
            ),
            const SizedBox(height: 8),
            // OCR 버튼
            OutlinedButton(
              onPressed: () {
                // OCR 화면으로 이동동
                Navigator.pushNamed(context, '/ocr');
              },
              child: const Text('OCR로 입력'),
            ),
          ],
        ),
      ),
    );
  }
}
