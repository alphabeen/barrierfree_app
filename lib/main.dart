import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'features/text_simplification/presentation/text_simp_screen.dart';
import 'features/ocr/presentation/ocr_screen.dart';

void main() {
  // Riverpod의 ProviderScope로 앱을 감싸 초기화
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toss Style Clean Architecture Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 쉬운말 변환 화면으로 이동
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TextSimplificationScreen(),
                  ),
                );
              },
              child: const Text('텍스트 쉬운말 변환'),
            ),
            const SizedBox(height: 16),
            // OCR 인식 화면으로 이동
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OcrScreen()),
                );
              },
              child: const Text('이미지 OCR 텍스트 추출'),
            ),
          ],
        ),
      ),
    );
  }
}
