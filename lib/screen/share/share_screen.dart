import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gather_here/common/storage/storage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ShareScreen extends ConsumerStatefulWidget {
  static get name => 'share';
  const ShareScreen({super.key});

  @override
  ConsumerState<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends ConsumerState<ShareScreen> {
  late final WebSocketChannel _channel;
  String message = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              connect();
            },
            child: Text('Connect Socket'),
          ),
          ElevatedButton(
            onPressed: () async {
              create();
            },
            child: Text('Create Socket'),
          ),
          ElevatedButton(
            onPressed: () {
              join();
            },
            child: Text('Join Socket'),
          ),
          ElevatedButton(
            onPressed: () {
              change();
            },
            child: Text('Change Socket'),
          ),
          Text(message),

          ElevatedButton(
            onPressed: () {
              close();
            },
            child: Text('Close Socket'),
          ),
        ],
      ),
    );
  }

  void connect() async {
    final storage = ref.read(storageProvider);
    final token = await storage.read(key: StorageKey.accessToken.name);

    print('token: $token');

    final wsUrl = Uri.parse(
        'ws://ec2-3-34-255-150.ap-northeast-2.compute.amazonaws.com:8080/location/share');
    _channel = IOWebSocketChannel.connect(
      wsUrl,
      headers: {'Authorization': '$token'},
    );

    await _channel.ready;

    print('connect?');

    _channel.stream.listen((message) {
      print(message.toString());

      setState(() {
        this.message = message.toString();
      });
    });
  }

  void close() async {
    _channel.sink.close(1000);
  }

  void create() async {
    final str = '''
                  {
                    "type" : "0",
                    "presentLat" : "1.2",
                    "presentLng" : "1.2",
                    "destinationDistance" : "500"
                  }
                ''';

    _channel.sink.add(str);

    print('create!!');
  }

  void join() async {
    final str = '''
                  {
                    "type" : "1",
                    "presentLat" : "1.2",
                    "presentLng" : "1.2",
                    "destinationDistance" : "500"
                  }
                ''';

    _channel.sink.add(str);

    print('join!!');
  }

  void change() async {
    final str = '''
                  {
                    "type" : "2",
                    "presentLat" : "1.2",
                    "presentLng" : "1.2",
                    "destinationDistance" : "500"
                  }
                ''';

    _channel.sink.add(str);

    print('change!!');
  }
}