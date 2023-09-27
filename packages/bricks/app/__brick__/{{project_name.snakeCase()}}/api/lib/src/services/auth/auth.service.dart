import 'package:chopper/chopper.dart';

import '../../models/_models.dart';

part 'auth.service.chopper.dart';

@ChopperApi()
abstract class AuthService extends ChopperService {
  static AuthService create([ChopperClient? client]) => _$AuthService(client);

  @Post(path: "/auth")
  Future<Response<AuthResultModel>> authPost({
    @Body() required AuthRequestModel body,
  });

  @Post(path: "/register")
  Future<Response<UserModel>> registerPost({
    @Body() required AuthRegisterModel body,
  });

  @Post(path: "/forgotten-password")
  Future<Response<Message>> forgottenPassword({
    @Body() required ForgottenRequestModel body,
  });

  @Post(path: "/reset-password")
  Future<Response<Message>> resetPassword({
    @Body() required ResetPasswordRequestModel body,
  });

  @Get(path: "/is-unique")
  Future<Response<Exists>> isUnique({
    @Query("email") String? email,
    @Query("username") String? username,
  });
}
