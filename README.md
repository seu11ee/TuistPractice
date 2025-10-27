# NewsHub

> Tuist를 활용한 iOS 뉴스 앱 개발 실습

## 학습 목표

- **Tuist 설치 및 프로젝트 생성**: 코드 기반 Xcode 프로젝트 관리
- **Tuist 모듈 설계와 의존성 관리**: Core Framework 분리를 통한 모듈화
- **XCTest 테스트 코드 작성**: Unit Test, Integration Test 구현
- **async/await concurrency 실습**: Modern Swift 비동기 처리

## 프로젝트 구조

```
NewsHub/             # SwiftUI 메인 앱
Core/                # 네트워킹 & 비즈니스 로직
TestHelpers/         # 테스트 유틸리티 (Mock 등)
```

## 구현 내용

- **NewsService**: URLSession + async/await 기반 API 통신
- **MVVM Architecture**: SwiftUI + ObservableObject 패턴
- **Error Handling**: 네트워크 에러 처리 및 사용자 피드백
- **Unit Testing**: MockNewsService를 활용한 테스트
- **Integration Testing**: 실제 API 호출 테스트

## 기술 스택

- **Tuist**: 프로젝트 생성 및 모듈 관리
- **SwiftUI**: UI 프레임워크
- **async/await**: Modern Swift Concurrency
- **XCTest**: 테스트 프레임워크
