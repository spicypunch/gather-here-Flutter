import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gather_here/common/repository/app_info_repository.dart';
import 'package:gather_here/common/storage/storage.dart';

// State
class SplashState {}

// Provider

final splashProvier =
    AutoDisposeStateNotifierProvider<SplashProvider, SplashState>((ref) {
  final storage = ref.watch(storageProvider);
  final appInfoRepository = ref.watch(appInfoRepositoryProvider);

  return SplashProvider(
    appInfoRepository: appInfoRepository,
    storage: storage,
  );
});

class SplashProvider extends StateNotifier<SplashState> {
  final AppInfoRepository appInfoRepository;
  final FlutterSecureStorage storage;

  SplashProvider({
    required this.appInfoRepository,
    required this.storage,
  }) : super(SplashState());

  void _setState() {
    state = SplashState();
  }

  Future<bool> getAppInfo() async {
    try {
      // 오토로그인 성공 -> Home화면으로 이동
      final result = await appInfoRepository.getAppInfo();
      storage.write(key: StorageKey.appInfo.name, value: result.appVersion);
      debugPrint('자동로그인 성공');
      return true;
    } catch (err) {
      // 오로로그인 실패 -> 로그인 화면으로 이동
      debugPrint('자동로그인 실패');
      return false;
    }
  }
}
