import 'dart:io';

import 'package:api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/_auth.dart';
import '../../config/_config.dart';
import '../_core.dart';

class GlobalBlocObserver extends BlocObserver {
  GlobalErrorCubit? errorCubit;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    if (bloc is GlobalErrorCubit) {
      errorCubit = bloc;
    }
    super.onCreate(bloc);
  }

  @override
  void onError(
    BlocBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) async {
    if (error is TokenException) {
      // only add this error when not inside the AuthBloc.
      // The [LoginBloc] and [RegisterBloc] should handle their own errors
      if (bloc is! RegisterBloc && bloc is! LoginBloc) {
        // if the ExceptionType is unauthorised log the auth out
        await locator<AuthRepository>().logout();
      }
    } else if (error is ApiException) {
      // Custom Api messages can be past into [ApiExceptionInterceptor] for all
      // exception types.
      errorCubit?.showErrorMessage(error.message!);
    } else if (error is SocketException) {
      // no internet, tell the auth
      errorCubit?.showErrorMessage(
        'Error connecting, please check connection and try again',
      );
    } else if (error is GlobalErrorMessage) {
      errorCubit?.showErrorMessage(error.message);
    } else {
      if (Config.instance.isDev) {
        debugPrint("❌ $error");
      }
      errorCubit?.showErrorMessage("An error has occurred. Please try again.");
    }

    super.onError(bloc, error, stackTrace);
  }
}
