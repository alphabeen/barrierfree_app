import 'package:flutter/material.dart';
// 서비스와 화면을 가져옴
import 'text_input_screen.dart';
import 'ocr_screen.dart';
import 'result_screen.dart';
import 'services/dummy_text_service.dart';
import 'models/translation_result.dart';

void main() {
  runApp(const TheSiUnMarlLo());
}

class TheSiUnMarlLo extends StatelessWidget {
  const TheSiUnMarlLo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The쉬운말로',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // 첫 화면을 '/'로 설정
      initialRoute: '/',
      routes: {
        '/': (context) => const TextInputScreen(),
        '/ocr': (context) => const OcrScreen(),
        // /result 는 arguments(결과 데이터)를 넘겨야 해서 onGenerateRoute로 따로 처리
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/result') {
          final args = settings.arguments;
          if (args is TranslationResult) {
            return MaterialPageRoute(
              builder: (context) => ResultScreen(result: args),
            );
          }
        }
        // /result 외의 다른 경로가 들어오면 null을 반환하여 라우팅 에러로 처리
        return null;
      },
    );
  }
}
