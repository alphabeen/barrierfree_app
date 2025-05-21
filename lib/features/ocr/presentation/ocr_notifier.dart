import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../ocr/domain/ocr_rep.dart';
import 'ocr_state.dart';
import '../../ocr/data/ocr_rep_impl.dart';

class OcrNotifier extends StateNotifier<OcrState> {
  final OcrRepository _repository;
  // ImagePicker는 플랫폼 채널을 통해 이미지 취득
  final ImagePicker _picker = ImagePicker();

  OcrNotifier(this._repository) : super(OcrState());

  /// 갤러리에서 이미지 선택
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return; // 사용자가 취소한 경우
      final file = File(image.path);
      // 선택한 이미지를 사용하여 OCR 처리
      await _processImage(file);
    } catch (e) {
      // 이미지 선택 중 에러 발생 시
      state = state.copyWith(error: '이미지를 불러오지 못했습니다: $e');
    }
  }

  /// 카메라로 이미지 촬영
  Future<void> captureImageWithCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final file = File(image.path);
      // 촬영한 이미지를 사용하여 OCR 처리
      await _processImage(file);
    } catch (e) {
      state = state.copyWith(error: '이미지 촬영에 실패했습니다: $e');
    }
  }

  // 내부적으로 공통 처리 로직: 이미지 파일을 받아 OCR 수행
  Future<void> _processImage(File image) async {
    // 이전 상태 초기화 후 로딩 시작 (선택된 이미지 지정, 결과/오류 초기화)
    state = OcrState(
      imageFile: image,
      extractedText: null,
      error: null,
      isLoading: true,
    );
    try {
      // 레포지토리를 통해 OCR 텍스트 추출
      final text = await _repository.extractTextFromImage(image);
      // 성공: 추출된 텍스트와 이미지를 상태에 반영 (로딩 종료)
      state = state.copyWith(
        extractedText: text,
        isLoading: false,
        error: null,
        imageFile: image,
      );
    } catch (e) {
      // 실패: 오류 상태 반영 (로딩 종료)
      state = state.copyWith(error: '텍스트 추출 실패: $e', isLoading: false);
    }
  }
}

// Repository 주입용 Provider
final ocrRepositoryProvider = Provider<OcrRepository>((ref) {
  return OcrRepositoryImpl();
});

// OcrNotifier의 Provider
final ocrNotifierProvider = StateNotifierProvider<OcrNotifier, OcrState>((ref) {
  final repo = ref.watch(ocrRepositoryProvider);
  return OcrNotifier(repo);
});
