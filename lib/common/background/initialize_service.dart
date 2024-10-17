import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gather_here/common/location/location_manager.dart';
import 'package:gather_here/common/model/socket_request_model.dart';
import 'package:gather_here/common/storage/storage.dart';
import 'package:gather_here/screen/share/socket_manager.dart';

const notificationChannelId = 'my_foreground';

const notificationId = 888;

void startBackgroundService() {
  final service = FlutterBackgroundService();
  service.startService();
}

void stopBackgroundService() {
  final service = FlutterBackgroundService();
  service.invoke("stopService");
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'MY FOREGROUND SERVICE',
    description: 'This channel is used for important notifications.',
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: notificationId,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final storage = FlutterSecureStorage();
  final socketManager = SocketManager(storage: storage);

  try {
    await socketManager.connect();
    _deliverInfo(socketManager, 1);

    socketManager.observeConnection().listen((message) {
        debugPrint('callback: $message');
      },
      onDone: () {
        socketManager.connect();
        _deliverInfo(socketManager, 1);

      },
      onError: (error) {
        debugPrint('소켓 에러 발생: $error');
        _deliverInfo(socketManager, 1);
      },
    );
  } catch (e) {
    debugPrint('소켓 연결 실패: $e');
  }

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    socketManager.close();
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
          notificationId,
          '위치 공유 중입니다.',
          '',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              notificationChannelId,
              'MY FOREGROUND SERVICE',
              // TODO: 아이콘 추후 수정
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }

    _deliverInfo(socketManager, 2);
  });
}

void _deliverInfo(SocketManager socketManager, int type) async {
  final locationManager = LocationManager();
  final storage = FlutterSecureStorage();
  final destinationLat = await storage.read(key: StorageKey.destinationLat.name);
  final destinationLng = await storage.read(key: StorageKey.destinationLng.name);

  final position = await locationManager.getCurrentPosition();
  final distance = locationManager.calculateDistance(
    position.latitude,
    position.longitude,
    double.parse(destinationLat!),
    double.parse(destinationLng!),
  );
  debugPrint('Background service running: latitude ${position.latitude}, longitude ${position.longitude}, distance $distance');
  socketManager.deliveryMyInfo(
    SocketRequestModel(
      type: 2,
      presentLat: position.latitude,
      presentLng: position.longitude,
      destinationDistance: distance,
    ),
  );
}