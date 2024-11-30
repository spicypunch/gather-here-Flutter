import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 스토리지 key값 정의
enum StorageKey {
  accessToken,
  refreshToken,
  appInfo,
  destinationLat,
  destinationLng,
  passWd
}

class StorageKeyState {
  String? appInfo;
  String? passWd;

  StorageKeyState({
    this.appInfo,
    this.passWd,
  });
}

final storageProvider = Provider((ref) => FlutterSecureStorage());

final storageKeyProvider = AutoDisposeStateNotifierProvider<StorageKeyProvider, StorageKeyState>((ref) {
    final storage = ref.watch(storageProvider);
    return StorageKeyProvider(storage: storage);
});

class StorageKeyProvider extends StateNotifier<StorageKeyState> {
  final FlutterSecureStorage storage;

  StorageKeyProvider({
    required this.storage,
  }) : super(StorageKeyState()) {
    getStorageKeys();
  }

  void _setState() {
    state = StorageKeyState(
      appInfo: state.appInfo,
      passWd: state.passWd,
    );
  }

  Future<void> getStorageKeys() async {
    state.appInfo = await storage.read(key: StorageKey.appInfo.name);
    state.passWd = await storage.read(key: StorageKey.passWd.name);
    _setState();
  }

  Future<void> updatePassWd(String passWd) async {
    storage.write(key: StorageKey.passWd.name, value: state.passWd);
    state.passWd = passWd;
  }

}
