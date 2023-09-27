import 'package:api/src/type_parser.dart';

import 'models/_models.dart';

final Map<Type, JsonFactory> factories = {
  IndexModel: IndexModel.fromJson,
  AuthUserModel: AuthUserModel.fromJson,
  AuthRegisterModel: AuthResultModel.fromJson,
  AuthResultModel: AuthResultModel.fromJson,
  UserCreateModel: UserCreateModel.fromJson,
  ForgottenRequestModel: ForgottenRequestModel.fromJson,
  ResetPasswordRequestModel: ResetPasswordRequestModel.fromJson,
  RoleModel: RoleModel.fromJson,
  UserModel: UserModel.fromJson,
  UserPatchModel: UserPatchModel.fromJson,
  AvatarModel: AvatarModel.fromJson,
  Message: Message.fromJson,
  MediaModel: MediaModel.fromJson,
  Exists: Exists.fromJson,
};
