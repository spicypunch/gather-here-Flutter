import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gather_here/common/model/request/nickname_model.dart';
import 'package:gather_here/common/model/response/member_info_model.dart';
import 'package:gather_here/common/repository/member_repository.dart';

import '../const/const.dart';
import '../dio/dio.dart';
import '../model/response/profile_image_url_model.dart';

class MemberInfoState {
  MemberInfoModel? memberInfoModel;
  String? message;

  MemberInfoState({
    this.memberInfoModel,
    this.message,
  });
}

final memberInfoProvider =
    AutoDisposeStateNotifierProvider<MemberInfoProvider, MemberInfoState>(
        (ref) {
  final memberRepository = ref.watch(memberRepositoryProvider);
  final dio = ref.watch(dioProvider);

  return MemberInfoProvider(
    memberRepository: memberRepository,
    dio: dio,
  );
});

class MemberInfoProvider extends StateNotifier<MemberInfoState> {
  final MemberRepository memberRepository;
  final Dio dio;

  MemberInfoProvider({
    required this.memberRepository,
    required this.dio,
  }) : super(MemberInfoState()) {
    getMyInfo();
  }

  void _setState() async {
    state = MemberInfoState(memberInfoModel: state.memberInfoModel, message: state.message);
    await Future.delayed(Duration(seconds: 1));
    state = MemberInfoState(memberInfoModel: state.memberInfoModel, message: null);
  }

  Future<void> getMyInfo() async {
    try {
      final memberInfo = await memberRepository.getMemberInfo();
      state.memberInfoModel = memberInfo;
      _setState();
    } catch (e, stackTrace) {
      debugPrint('getMyInfo: $e, $stackTrace');
    }
  }

  Future<void> changeNickName(String nickName) async {
    try {
      await memberRepository.patchChangeNickName(
        body: NicknameModel(nickname: nickName),
      );
      state.message = '닉네임 변경에 성공하였습니다';
      getMyInfo();
    } catch (e) {
      state.message = '닉네임 변경에 실패하였습니다.';
      _setState();
    }
  }

  void changeProfileImage(File imageFile) async {
    try {
      final fileName = imageFile.path.split('/').last;

      final multipartFile = await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      );

      final formData = FormData.fromMap({
        'imageFile': multipartFile,
      });

      final response = await dio.post(
        '${Const.baseUrl}/members/profile',
        data: formData,
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      if (response.statusCode == 200) {
        final profileImageUrlModel =
            ProfileImageUrlModel.fromJson(response.data);

        state.message = '프로필 사진이 업데이트 되었습니다.';
        state.memberInfoModel = state.memberInfoModel?.copyWith(profileImageUrl: profileImageUrlModel.imageUrl);
        _setState();
      } else {
        debugPrint('Server responded with status code: ${response.statusCode}');
        state.message = '프로필 사진 업데이트에 실패하였습니다.';
        _setState();
      }
    } catch (e) {
      state.message = '프로필 사진 업데이트에 실패하였습니다.';
      _setState();

      if (e is DioException) {
        debugPrint('changeProfileImage Dio Error: ${e.message}');
        debugPrint('Response: ${e.response?.data}');
      } else {
        debugPrint('changeProfileImage Unknown Error: $e');
      }
    }
  }
}
