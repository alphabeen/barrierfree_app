import 'package:flutter/material.dart';

class OcrScreen extends StatelessWidget {
  const OcrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 나중에 구현할 OCR 기능을 여기에 추가
            // 지금은 버튼만 있고 실제 동작X
          },
          child: const Text('이미지에서 텍스트 읽기'),
        ),
      ),
    );
  }
}
