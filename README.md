The쉬운말로 – Flutter 기반 문해력 향상 앱
The쉬운말로는 발달장애인, 고령자, 초등학생, 외국인 등 문해력이 낮은 사용자를 위해,
복잡하거나 어려운 문장을 더 쉽고 일상적인 표현으로 변환해주는 Flutter 기반 모바일 애플리케이션입니다.

현재는 더미 데이터를 기반으로 구성된 기능 흐름을 테스트하는 단계이며,
향후 GPT API 연동, OCR 문자 인식, TTS 음성 출력, 다국어 번역 등
다양한 접근성 기능을 통합하는 실제 서비스 확장 구조를 반영하여 개발 중입니다.

📌 주요 기능 및 구현 현황
📝 문장 → 쉬운말 변환 (ViewModel + Dummy API 기반)
사용자가 입력한 문장을 GPT 스타일 프롬프트를 적용한 형태로 더 쉽게 변환

현재는 dummy_text_service.dart 를 통해 임의 변환 결과를 반환하도록 설계됨

구조상 실제 API (OpenAI, KoBERT 기반 등) 연동 시 빠르게 대체 가능

결과는 별도 화면에 입력/출력 텍스트 쌍 형태로 출력

📷 OCR 기반 이미지 → 텍스트 추출 (기본 UI 세팅 완료)
Google ML Kit OCR 연동을 위한 구조를 설계 중

ocr_view.dart, ocr_view_model.dart 등 ViewModel/UseCase 분리 기반 구성

버튼 및 UI 화면은 구현 완료, 추후 텍스트 변환 흐름과 연동 예정

🔊 TTS 및 STT 기능 (추가 예정)
쉬운 말로 변환된 문장을 음성으로 들려주는 기능 (Text-to-Speech) 연동 계획

향후 음성 입력(Speech-to-Text) 을 통한 비문해 사용자 접근성 개선도 포함

🧱 프로젝트 구조 (Clean Architecture 기반 Feature-first 구조)
features/
기능별로 data, domain, presentation 폴더 구분 (문장 변환, OCR 등)

core/
공통 유틸리티, 상수, 라우팅, 테마, 에러 핸들링 등

services/
API 통신, 로컬 데이터 처리, 캐싱 처리 등 외부 연동 영역

presentation/
View, Router, 전역 UI 요소 정리 (입력창, 버튼, 결과창 등)

lib/
→ 기능별로 명확히 분리된 구조로, 추후 확장/유지보수 용이

🚀 실행 방법
git clone https://github.com/alphabeen/barrierfree_app.git
cd barrierfree_app
flutter pub get
flutter run

Flutter SDK 3.29.3 이상 필요

Android/iOS 에뮬레이터 또는 실기기에서 실행 가능

iOS는 별도 플랫폼 권한 설정 필요

🔭 향후 개발 계획 및 확장 로드맵
✅ GPT API 연동 통한 실제 쉬운 말 변환 로직 구현

✅ Google ML Kit OCR API 기반 이미지 텍스트 인식 기능 완성

✅ TTS 음성 출력 및 STT 입력 기능 추가

✅ 쉬운말 → 영어 번역 기능 (Google Translate API)

✅ 변환 이력 저장 및 공유 기능 (local storage / 공유 API)

✅ 국립국어원 기반 퀴즈 기능 (어려운 단어 학습)

✅ Firebase 기반 사용자 인증 및 분석 기능 추가 예정

✅ Flutter 접근성 API(WAI-ARIA 대응) 기반 모바일 UX 개선

✅ 사용자 피드백 데이터 기반 HuggingFace 모델 Fine-tuning (PyTorch/TensorFlow 활용)

💡 개발 목적
이 앱은 단순한 Flutter 학습 예제가 아닌,
실제 정보 접근에 어려움을 겪는 사용자들을 위한 실질적인 서비스 앱을 지향합니다.
모든 사람이 정보를 이해하고 활용할 수 있는 세상을 만드는 데 기여하는 것을 목표로 합니다.

📣 참고 및 사용 안내
이 프로젝트는 콘테스트 출품용 MVP 및 실험적 구조 구현을 포함하며,

누구든 구조를 참고하거나 기능을 확장하여 활용 가능하나,

실제 서비스용으로 사용 시 별도의 데이터, 인증, 보안 구조 설계가 필요합니다.