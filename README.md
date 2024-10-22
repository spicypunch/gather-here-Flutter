# 여기로 모여라
이동 경로를 함께 공유하세요!

우리 앱은 친구들과 목적지로 가는 여정을 실시간으로 공유할 수 있도록 도와줘요.

방을 생성하고 친구들에게 코드만 공유하면, 모두가 같은 지도에서 서로의 현재 위치와 목표지점까지의 거리를 확인할 수 있어요.

지도에 표시된 마커와 바텀 시트를 통해 누가 가장 빠르게 목적지에 도착할지 등수도 확인할 수 있어요.

함께하는 이동이 더 즐거워질 거예요!

지금 바로 친구들과 함께 경로를 공유해보세요.

## 기술 스택
- 상태 관리
  - riverpod: 의존성 주입과 상태 관리 방식이 마음에 들었고 앱에서 여러 화면 간 데이터 흐름을 효과적으로 관리하기 위해 선택했어요.
  - hooks_riverpod: riverpod으로 전역 상태를 관리하고 있고 로컬 상태를 관리할 땐 hooks_riverpod을 적용하여 상태 관리를 분리하고 있어요.
- HTTP 통신
  - dio: dio를 사용하는 이유는 다양한 HTTP 요청 메소드를 쉽게 보낼 수 있고, 인터셉터를 이용해 요청을 보내기 전, 응답을 받기 전에 원하는 동작을 추가하거나 로그를 남길 수 있어요.
  - retrofit: dio를 기반으로 더욱 간결하고 선언적으로 코드를 작성하여 가독성을 높이고, json_serializable과 같은 패키지와 결합하여 JSON을 자동으로 데이터 모델로 변환할 수 있어요.
- 소켓 통신
  - web_socket_channel: WebSocketChannel 객체를 생성하여 간단하게 소켓 연결을 구현할 수 있어요.
- 백그라운드
  - flutter_background_service: 백그라운드 라이브러리 중 소켓 연결에 대한 예제를 보여주며, 무료 라이브러리로 배포 중이라 사용하고 있어요.
- 네비게이션
  - go_router: 기본 제공하는 Navigator 보다 패턴을 간결하고 선언적으로 처리할 수 있어 사용하고 있어요.

## UI
- 로그인 화면
![KakaoTalk_Photo_2024-10-22-19-33-32 008](https://github.com/user-attachments/assets/78633329-a94c-46ef-83b8-10db5af1ebe5)
![KakaoTalk_Photo_2024-10-22-19-33-32 007](https://github.com/user-attachments/assets/c7e65156-5aef-4f75-b36f-0fb6c33e2ae7)
![KakaoTalk_Photo_2024-10-22-19-33-32 006](https://github.com/user-attachments/assets/e95f3ae2-ada4-4eb3-a400-cde8514bc787)
![KakaoTalk_Photo_2024-10-22-19-33-32 005](https://github.com/user-attachments/assets/29c63d28-ad4f-4d4a-8b25-c18523dd29e5)
![KakaoTalk_Photo_2024-10-22-19-33-31 004](https://github.com/user-attachments/assets/280e5671-b9a1-4bc3-9b15-ff08718c80ea)
![KakaoTalk_Photo_2024-10-22-19-33-31 003](https://github.com/user-attachments/assets/36b12077-58d0-449d-b4de-2611e5018145)
![KakaoTalk_Photo_2024-10-22-19-33-31 002](https://github.com/user-attachments/assets/928ceed7-2c13-4580-9071-54847615a05c)
![KakaoTalk_Photo_2024-10-22-19-33-31 001](https://github.com/user-attachments/assets/68c1a8f6-6f5e-47c0-a055-5bc9a50795f6)
