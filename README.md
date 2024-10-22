# 여기로 모여라
이동 경로를 함께 공유하세요!

우리 앱은 친구들과 목적지로 가는 여정을 실시간으로 공유할 수 있도록 도와줘요.

방을 생성하고 친구들에게 코드만 공유하면, 모두가 같은 지도에서 서로의 현재 위치와 목표지점까지의 거리를 확인할 수 있어요.

지도에 표시된 마커와 바텀 시트를 통해 누가 가장 빠르게 목적지에 도착할지 등수도 확인할 수 있어요.

함께하는 이동이 더 즐거워질 거예요!

지금 바로 친구들과 함께 경로를 공유해보세요.

<br>
<br>

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

<br>
<br>

## UI
#### 로그인 화면
<img src="https://github.com/user-attachments/assets/7a292280-bc91-448b-b9d6-71a55b4ea03b" width=200>
<img src="https://github.com/user-attachments/assets/05f9f4bd-9952-4ea8-aa4d-23ea116fc01d" width=200>

- 휴대폰 번호 11자리, 비밀번호 4자리 이상일 경우 로그인 버튼을 활성화 해요.

<br>
 
#### 회원가입 화면
<img src="https://github.com/user-attachments/assets/9976833a-935c-4b12-9504-efdef4e4e362" width=200>
<img src="https://github.com/user-attachments/assets/3cebf48a-6983-4c0e-8bc2-acde8944fea6" width=200>

- 휴대폰 번호 11자리, 비밀번호 4자리 이상, 비밀번호 확인, 약관 동의 여부를 확인 후 회원가입 버튼을 활성화 해요.

<br>

#### 홈 화면
<img src="https://github.com/user-attachments/assets/7c3f155e-aa4b-47f1-985a-7640660b9a63" width=200>
<img src="https://github.com/user-attachments/assets/4939c833-363e-4e4b-97af-3433829579cd" width=200>
<img src="https://github.com/user-attachments/assets/38f7a394-2ede-443f-99e6-2c33d4d6bec0" width=200>

- 목적지를 검색하고 약속 시간을 설정해요.
- 약속 시간은 최대 24시간 후 까지만 설정 가능해요.
- 위치 공유하기를 클릭하면 방이 생성돼요.

<br>

#### 위치공유 방 화면
* 시연 영상 제작 중입니다.

<br>

#### 마이 페이지 화면
<img src="https://github.com/user-attachments/assets/ea5e93d1-5b32-4eaa-b667-2bebf11b9281" width=200>
<img src="https://github.com/user-attachments/assets/0e5cfa73-c9b3-470b-b3b7-be2b311816d9" width=200>

- 내 프로필 사진, 닉네임, 비밀번호 등을 변경할 수 있어요.
- 로그아웃 및 회원 탈퇴도 가능해요.


