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
void closeSocketConnect() {
  final service = FlutterBackgroundService();
  service.invoke("closeSocket");
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

  final locationManager = LocationManager();
  final storage = FlutterSecureStorage();
  final socketManager = SocketManager(storage);

  final destinationLat =
  await storage.read(key: StorageKey.destinationLat.name);
  final destinationLng =
  await storage.read(key: StorageKey.destinationLng.name);

  try {
    await socketManager.connect();
    socketManager.observeConnection().listen((message) {
      debugPrint('callback in background: $message');
    }, onError: (error) {
      debugPrint('소켓 에러 발생: $error');
      socketManager.connect();
    }, onDone: () {
      print('onDone in background');
    });
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

  service.on('closeSocket').listen((event) {
    socketManager.close();
  });

  service.on('stopService').listen((event) {
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
              // 아이콘 추후 수정
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }
    final position = await locationManager.getCurrentPosition();
    final distance = locationManager.calculateDistance(
      position.latitude,
      position.longitude,
      double.parse(destinationLat!),
      double.parse(destinationLng!),
    );
    debugPrint(
        'Background service running: latitude ${position.latitude}, longitude ${position.longitude}, distance $distance');

    if (socketManager.isConnected()) {
      socketManager.deliveryMyInfo(
        SocketRequestModel(
          type: 2,
          presentLat: position.latitude,
          presentLng: position.longitude,
          destinationDistance: distance,
        ),
      );
    } else {
      debugPrint('소켓 연결이 끊어졌습니다. 재연결 시도 중...');
      try {
        await socketManager.connect();
      } catch (e) {
        debugPrint('재연결 실패: $e');
      }
    }
  });
}

// import 'dart:async';
// import 'dart:math';
// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:gather_here/common/model/socket_request_model.dart';
// import 'package:gather_here/common/storage/storage.dart';
// import 'package:gather_here/screen/share/socket_manager.dart';
//
// const notificationChannelId = 'my_foreground';
//
// const notificationId = 888;
//
// void startBackgroundService() {
//   final service = FlutterBackgroundService();
//   service.startService();
// }
// void closeSocketConnect() {
//   final service = FlutterBackgroundService();
//   service.invoke("closeSocket");
// }
//
// void stopBackgroundService() {
//   final service = FlutterBackgroundService();
//   service.invoke("stopService");
// }
//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     notificationChannelId,
//     'MY FOREGROUND SERVICE',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.low,
//   );
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart,
//       autoStart: false,
//       isForegroundMode: true,
//       notificationChannelId: notificationChannelId,
//       initialNotificationTitle: 'AWESOME SERVICE',
//       initialNotificationContent: 'Initializing',
//       foregroundServiceNotificationId: notificationId,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: false,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//   );
// }
//
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   return true;
// }
//
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   final storage = FlutterSecureStorage();
//   final socketManager = SocketManager(storage);
//
//   final destinationLat =
//       await storage.read(key: StorageKey.destinationLat.name);
//   final destinationLng =
//       await storage.read(key: StorageKey.destinationLng.name);
//
//   try {
//     await socketManager.connect();
//     socketManager.observeConnection().listen((message) {
//       debugPrint('callback in background: $message');
//     }, onError: (error) {
//       debugPrint('소켓 에러 발생: $error');
//       // 재연결 시도
//       socketManager.connect();
//     }, onDone: () {
//       print('onDone in background');
//     });
//   } catch (e) {
//     debugPrint('소켓 연결 실패: $e');
//   }
//
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('closeSocket').listen((event) {
//     socketManager.close();
//   });
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   bg.BackgroundGeolocation.ready(bg.Config(
//     desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
//     distanceFilter: 10.0,
//     stopOnTerminate: false,
//     startOnBoot: true,
//     enableHeadless: true,
//   )).then((bg.State state) {
//     if (!state.enabled) {
//       bg.BackgroundGeolocation.start();
//     }
//   });
//
//   bg.BackgroundGeolocation.onLocation((bg.Location location) async {
//     final distance = calculateDistance(
//       location.coords.latitude,
//       location.coords.longitude,
//       double.parse(destinationLat!),
//       double.parse(destinationLng!),
//     );
//
//     if (socketManager.isConnected()) {
//       socketManager.deliveryMyInfo(
//         SocketRequestModel(
//           type: 2,
//           presentLat: location.coords.latitude,
//           presentLng: location.coords.longitude,
//           destinationDistance: distance,
//         ),
//       );
//     } else {
//       debugPrint('소켓 연결이 끊어졌습니다. 재연결 시도 중...');
//       try {
//         await socketManager.connect();
//       } catch (e) {
//         debugPrint('재연결 실패: $e');
//       }
//     }
//   });
//
//   // Timer.periodic(const Duration(seconds: 5), (timer) async {
//   //   if (service is AndroidServiceInstance) {
//   //     if (await service.isForegroundService()) {
//   //       flutterLocalNotificationsPlugin.show(
//   //         notificationId,
//   //         '위치 공유 중입니다.',
//   //         '',
//   //         const NotificationDetails(
//   //           android: AndroidNotificationDetails(
//   //             notificationChannelId,
//   //             'MY FOREGROUND SERVICE',
//   //             // 아이콘 추후 수정
//   //             icon: 'ic_bg_service_small',
//   //             ongoing: true,
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   }
//   // });
// }
//
// double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
//   const R = 6371000; // Radius of the Earth in meters
//   final double dLat = _degToRad(endLat - startLat);
//   final double dLng = _degToRad(endLng - startLng);
//
//   final double a = sin(dLat / 2) * sin(dLat / 2) +
//       cos(_degToRad(startLat)) * cos(_degToRad(endLat)) *
//           sin(dLng / 2) * sin(dLng / 2);
//
//   final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//   final double distance = R * c;
//
//   return distance; // Distance in meters
// }
//
// double _degToRad(double degree) {
//   return degree * (pi / 180);
// }