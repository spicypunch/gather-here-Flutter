# 여기로 모여라

약속 기반 실시간 위치공유 앱

- 호스트는 지도에서 검색을 통해 약속 장소/시간을 지정할 수 있음
- 참여자는 호스트의 참여 코드를 통해 해당 약속에 참석할 수 있음
- 지도에서는 약속장소, 참여자들의 실시간 위치를 볼 수 있음
- 목적지까지의 남은거리, 실시간 랭킹을 확인 가능

## 스크린샷 및 동영상

### 스크린샷

<img src = "https://github.com/user-attachments/assets/6620159c-bde7-43bb-b287-b0fe635466ee" width = "180">
<img src = "https://github.com/user-attachments/assets/884be468-883b-4e48-b9ff-b9f88df9fea3" width = "180">
<img src = "https://github.com/user-attachments/assets/42eccfdb-bf17-421a-b8ee-79ca114ee573" width = "180">
<img src = "https://github.com/user-attachments/assets/f26bfaf7-6163-4f00-a83d-8c5a5b5e7028" width = "180">
<img src = "https://github.com/user-attachments/assets/0ec92422-76f8-4436-b384-b4273a3c2637" width = "180">

### 동영상
<img src = "https://github.com/user-attachments/assets/28f276da-c0d8-4891-bdae-bb571d823d95" width = "300">

## 개발환경

- IDE: Andriod Studio
- Language: Dart(Flutter)

## 팀원

|이름|역할|Github URL|
|---|---|---|
|김도연|Front|https://github.com/FirstDo|
|김종민|Front|https://github.com/spicypunch|
|김산하|Server|https://github.com/kimsanhaa|

## 트러블슈팅

### 웹 소켓 연결이 자꾸 끊기는 이슈

Stateless, Connectionless한 REST api와는 달리, 웹소켓은 클라이언트 - 서버의 연결을 안정적으로 유지해야한다.  
그런데 아무리 연결을 해도, 시간이 지나면 끊겨버리는 문제가 있었다.

팀원들과 논의 끝에 현재 사용자가 위치공유중인지 판단하는 rest api를 하나 만든다음
연결이 끊겼을때 콜백을 받는 함수에서, 해당 api를 다시 쏴서, 결과에 따라 다시 연겷해주던가 정상적으로 종료하던가 식으로 구현하였다.

### 백그라운드에서 위치정보를 가져오지 못하는 이슈

기본적으로 지도 앱이다 보니, 앱이 백그라운드 상태일때도 실시간으로 위치정보를 가져와서 웹소켓을 통해 서버에 보내줘야 한다.  
아무리 라이브러리를 찾아봐도, iOS/Android 양 플랫폼에서 제대로, 잘 동작하는 '무료' 라이브러리를 찾기가 힘들었다.

결국 실시간으로 위치정보를 받아오는 방법은 포기하고 
그 대안으로 `flutter_background_service` 라는 라이브러리를 사용해서, 앱이 백그라운드에 들어갔을때 타이머를 돌려서
정해진 시간마다 현재 위치를 그냥 가져오고 그 값을 서버에 보내는 식으로, 비슷한 효과를 내는것처럼 보이게끔 구현하였다.

### 안드로이드와 iOS에서 AppLifecycleState이 다르게 적용되는 이슈

앱이 무조건 위치정보가 필요하다보니, 위치 권한을 허용하지 않았을때 Alert을 띄워서 다시 위치권한 설정 화면으로 보낼 수 있도록 구현하였다.

iOS에서는 background -> foreground로 앱의 상태가 바뀔때만 flutter AppState가 resumed 된다.  
Android에서는 background -> foreground일때, 그리고 alert을 닫았을때 역시 resumed이 되는 문제가 있었다.

두 플랫폼을 분기해서 해결하였다.


## 사용 라이브러리

- cupertino_icons: ^1.0.6
- go_router: ^7.1.0
- flutter_riverpod: ^2.5.1
- dio: ^5.5.0+1
- flutter_secure_storage: ^5.0.2
- retrofit: ^4.2.0
- logger: any
- google_maps_flutter: ^2.9.0
- easy_debounce: ^2.0.3
- geolocator: ^13.0.1
- json_annotation: ^4.9.0
- image_picker: ^0.8.7+4
- web_socket_channel: ^3.0.1
- intl: ^0.19.0
- flutter_localization: ^0.2.2
- flutter_cache_manager: ^3.4.1
- http: ^1.2.2
- flutter_background_service: ^5.0.10
- flutter_local_notifications: ^17.2.3
- permission_handler: ^11.3.0
- url_launcher: ^6.3.1
- app_settings: ^5.1.1
- image: ^4.3.0
- cached_network_image: ^3.2.3
- hooks_riverpod: ^2.6.0


## 개발자에게 연락하기
[카카오톡](https://pf.kakao.com/_xkRPxhn)
