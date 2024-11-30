import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:gather_here/common/model/request/sign_up_model.dart';
import 'package:retrofit/http.dart';

import 'package:gather_here/common/dio/dio.dart';
import 'package:gather_here/common/const/const.dart';
import 'package:gather_here/common/model/request/login_model.dart';

part 'auth_repository.g.dart';

final authRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio, baseUrl: Const.baseUrl);
});

// http://ec2-13-124-216-179.ap-northeast-2.compute.amazonaws.com:8080
@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = _AuthRepository;

  @POST('/login')
  Future<void> postLogin({
    @Body() required LoginModel body,
  });

  @POST('/members')
  Future<void> postSignUp({
    @Body() required SignUpModel body,
  });

  @DELETE('/members')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> deleteMember();
}
