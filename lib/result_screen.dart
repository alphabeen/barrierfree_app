import 'package:flutter/material.dart';
import 'models/translation_result.dart';

class ResultScreen extends StatelessWidget {
  final TranslationResult result;
  const ResultScreen({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('변환 결과')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('원문:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(result.original, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            Text('쉬운 말:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              result.simplified,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
