import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gather_here/common/const/const.dart';
import 'package:gather_here/common/model/socket_request_model.dart';
import 'package:gather_here/common/storage/storage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final socketManagerProvider = Provider((ref) {
  final storage = ref.watch(storageProvider);
  final socketManager = SocketManager(storage);
  return socketManager;
});

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late WebSocketChannel _channel;
  late FlutterSecureStorage storage;

  factory SocketManager(FlutterSecureStorage storage) {
    _instance.storage = storage;
    return _instance;
  }

  SocketManager._internal();

  void initialize(FlutterSecureStorage storage) {
    this.storage = storage;
  }

  Future<void> connect() async {
    final token = await storage.read(key: StorageKey.accessToken.name);

    final wsUrl = Uri.parse(Const.socketUrl);
    _channel = IOWebSocketChannel.connect(
      wsUrl,
      headers: {'Authorization': '$token'},
    );

    await _channel.ready;
    print('Socket Connected');
  }

  Future<void> close() async {
    await _channel.sink.close(1000);
  }

  Stream<dynamic> observeConnection() {
    return _channel.stream;
  }

  void deliveryMyInfo(SocketRequestModel model) {
    final jsonString = jsonEncode(model.toJson());
    _channel.sink.add(jsonString);

    print('send Information!!');
  }

  bool isConnected() {
    return _channel != null && _channel.closeCode == null;
  }
}
