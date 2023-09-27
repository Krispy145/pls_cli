import 'package:chopper/chopper.dart';

import '../../models/_models.dart';

part 'user.service.chopper.dart';

@ChopperApi(baseUrl: "/users")
abstract class UserService extends ChopperService {
  static UserService create([ChopperClient? client]) => _$UserService(client);

  ///Returns a listing of User resources with filtering and pagination support.
  // @Get()
  // Future<Response<UserList>> indexUsers();

  ///Creates a new instance of a single User resource.
  @Post()
  Future<Response<UserModel>> storeUser({
    @Body() required UserCreateModel body,
  });

  ///Returns a single User resource by id.
  ///@param user_id The Uuid for the User
  @Get(path: '/{user_id}')
  Future<Response<UserModel>> showUser({
    @Path('user_id') required String? userId,
  });

  ///Replaces (or updates all data of) a single User resource.
  ///@param user_id The Uuid for the User
  @Put(path: '/{user_id}')
  Future<Response<UserModel>> updateUser({
    @Path('user_id') required String? userId,
    @Body() required UserCreateModel? body,
  });

  ///Modifies (parts of) a single User resource.
  ///@param user_id The Uuid for the User
  @Patch(path: '/{user_id}')
  Future<Response<UserModel>> patchUser({
    @Path('user_id') required String? userId,
    @Body() required UserPatchModel? body,
  });

  ///Destroys a single User resource.
  ///@param user_id The Uuid for the User
  @Delete(path: '/{user_id}')
  Future<Response<Message>> destroyUser({
    @Path('user_id') required String? userId,
  });
}
