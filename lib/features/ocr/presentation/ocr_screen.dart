import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_app/features/ocr/presentation/ocr_notifier.dart';

class OcrScreen extends HookConsumerWidget {
  const OcrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // OCR 상태 구독
    final ocrState = ref.watch(ocrNotifierProvider);
    // 이미지 선택/촬영 동작을 수행할 Notifier 참조
    final ocrNotifier = ref.read(ocrNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('이미지 OCR 추출')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. 이미지 미리보기 영역
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[200],
              child:
                  ocrState.imageFile != null
                      ? Image.file(ocrState.imageFile!, fit: BoxFit.cover)
                      : const Center(child: Text('선택된 이미지가 없습니다')),
            ),
            const SizedBox(height: 16),
            // 2. 갤러리 선택 및 카메라 촬영 버튼들
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed:
                      ocrState.isLoading
                          ? null
                          : () {
                            // 갤러리에서 이미지 선택
                            ocrNotifier.pickImageFromGallery();
                          },
                  icon: const Icon(Icons.photo),
                  label: const Text('갤러리에서 선택'),
                ),
                ElevatedButton.icon(
                  onPressed:
                      ocrState.isLoading
                          ? null
                          : () {
                            // 카메라로 이미지 촬영
                            ocrNotifier.captureImageWithCamera();
                          },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('카메라 촬영'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 3. OCR 추출 결과 및 상태 표시
            if (ocrState.isLoading) ...[
              const CircularProgressIndicator(),
              const Text('텍스트 추출 중...', style: TextStyle(fontSize: 16)),
            ] else if (ocrState.error != null) ...[
              Text(
                ocrState.error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ] else if (ocrState.extractedText != null) ...[
              Text(
                '인식된 텍스트: ${ocrState.extractedText!}',
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
