# 💬 Gemini 기반 AI 챗 서비스

이 프로젝트는 **Flutter**와 **Gemini API**를 사용하여 간단한 AI 챗봇 애플리케이션을 구현한 예제입니다. <br/>사용자는 Gemini API를 통해 자연스러운 대화를 나눌 수 있습니다.

## 📑 목차
1. [프로젝트 소개](#-프로젝트-소개)
2. [프로젝트 구조](https://github.com/rlnrlnworld/chatgpt-app/blob/main/README.md#%EF%B8%8F-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EA%B5%AC%EC%A1%B0)
3. [사용 기술](#-사용-기술)
4. [설치](https://github.com/rlnrlnworld/chatgpt-app/blob/main/README.md#%EF%B8%8F-%EC%84%A4%EC%B9%98)
5. [사용 방법](#-사용-방법)
6. [구현 기능](#-구현-기능)
7. [라이선스](#-라이선스)

## 📖 프로젝트 소개
이 프로젝트는 **Gemini API**를 사용하여 간단한 AI 챗 서비스를 구현한 Flutter 애플리케이션입니다. <br/>사용자는 앱 내에서 자연어로 질문을 입력하면 AI가 실시간으로 응답을 생성하여 제공합니다. <br/>**상태 관리**와 **Gemini API**의 통합을 통해 실시간으로 응답이 반영되는 인터랙티브한 사용자 경험을 제공합니다.

## 🗂️ 프로젝트 구조
```
📦 chatgpt-app
├─ README.md
├─ analysis_options.yaml
├─ assets
│  └─ logo.png
├─ lib
│  ├─ main.dart
│  └─ model.dart
├─ pubspec.yaml
└─ web
   ├─ favicon.png
   ├─ icons
   │  ├─ Icon-192.png
   │  ├─ Icon-512.png
   │  ├─ Icon-maskable-192.png
   │  └─ Icon-maskable-512.png
   ├─ index.html
   └─ manifest.json
```

## 💻 사용 기술
- **Flutter**: 프론트엔드 및 사용자 인터페이스 구현
- **Gemini API**: AI 챗봇 응답 생성
- **Dart**: 로직 및 상태 관리
- **Vercel**: 배포 및 호스팅 (예정)

## ⚙️ 설치
1. 레포지토리 클론:
   ```bash
   git clone https://github.com/your-repo/gemini_chat_app.git
   cd gemini_chat_app
   ```
2. 의존성 설치
    ```bash
    flutter pub get
    ```
3. API 키 설정
   - lib/main.dart 파일에서 `Gemini.init(apiKey: YOUR_API_KEY)` 부분에 자신의 Gemini API 키를 추가합니다.
     
4. 애플리케이션 실행
   ```bash
   flutter run
   ```
## 🚀 사용 방법
1. 앱을 실행하면, 기본적으로 빈 화면이 나타납니다.
2. 메시지 입력란에 질문을 입력하고 전송 버튼을 누르면 Gemini API가 해당 질문에 대한 응답을 생성합니다.
3. 실시간으로 AI가 응답을 생성하여 대화형 인터페이스를 제공합니다.
   
## ✨ 구현 기능
- 실시간 채팅: 사용자의 질문에 대한 AI의 실시간 응답 제공
- 상태 관리: Flutter의 상태 관리 기능을 활용하여 채팅 내용의 실시간 업데이트
- Gemini API 통합: 사용자가 입력한 텍스트를 Gemini API로 전달하고, AI 응답을 받아와 화면에 출력
  
## 📄 라이선스
이 프로젝트는 학습 및 연구 목적으로 만들어졌으며, 상업적 목적으로 사용할 수 없습니다.

