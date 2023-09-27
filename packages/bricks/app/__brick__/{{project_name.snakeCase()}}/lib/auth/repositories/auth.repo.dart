import 'dart:async';

import 'package:api/api.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../config/_config.dart';
import '../../core/_core.dart';

class AuthRepository {
  /// The current authentication status of a user.
  final ClientSdk _client = locator<ClientSdk>();
  AuthUserModel? _currentUser;

  final BehaviorSubject<AuthUserModel?> _controller =
      BehaviorSubject<AuthUserModel?>();

  AuthRepository();

  /// Stream containing the [AuthUserModel] which is decoded from the JWT.
  Stream<AuthUserModel?> get stream => _controller.stream;
  AuthUserModel? get currentUser => _currentUser;

  /// Checks the current authenticated state of the user.
  ///
  /// Returns null if no JWT is available.
  Future<AuthUserModel?> checkAuth() async {
    try {
      final token = await _client.token.checkTokenValidity();

      final AuthUserModel? user =
          token != null ? AuthUserModel.fromJson(token.userMap) : null;

      // Set the user stream to trigger auth navigator.
      _setUser(user);
      debugPrint("User logged in : $user");

      if (user != null && locator.currentScopeName != "loggedIn") {
        locator.pushNewScope(
          scopeName: "loggedIn",
          init: (i) => postLoginSetup(user.userId, i),
        );
      }

      // Return user or null to auth bloc.
      // If null is returned then Status.unauthenticated is emitted.
      // If a user it returned then nothing is emitted as the user stream will trigger an authenticated status.
      return user;
    } catch (e) {
      await logout();
      return null;
    }
  }

  Future<void> deleteUser(String id) async {
    await _client.api.user.destroyUser(userId: id);
    await logout();
  }

  /// Login a user with their email and password.
  Future<AuthUserModel?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _client.api.auth.authPost(
      body: AuthRequestModel(
        grantType: GrantType.password,
        clientId: Config.instance.clientId,
        clientSecret: Config.instance.clientSecret,
        password: password,
        username: email,
      ),
    );
    if (response.body != null) {
      await _client.token.setTokenInfo(
        accessToken: response.body!.accessToken,
        refreshToken: response.body!.refreshToken,
      );
      // tokens are stored so checking auth should log the user in
      return checkAuth();
    }
    return null;
  }

  /// Register a user with their email address.
  Future<void> registerWithEmail({required AuthRegisterModel user}) async {
    final res = await _client.api.auth.registerPost(body: user);
    if (res.body != null) {
      await loginWithEmail(email: user.email, password: user.password);
    }
  }

  /// Send a reset password email.
  Future<bool> forgottenPassword(String email) async {
    throw UnimplementedError();

    // ignore_for_file: dead_code
    const String bundleId = "";
    final String uriPrefix = Config.instance.resetPasswordUri;
    // ignore: unused_local_variable
    final Uri link = Uri.parse(
      "$uriPrefix/reset-password?email=$email&token={token}",
    );

    //Set the dynamic link parameters ready for building the link
    final params = DynamicLinkParameters(
      link: link,
      uriPrefix: uriPrefix,
      iosParameters: const IOSParameters(bundleId: bundleId),
      androidParameters: const AndroidParameters(packageName: bundleId),
    );

    // //Build the reset url using the above parameters
    final resetUrl = await FirebaseDynamicLinks.instance.buildLink(params);

    //Send reset password request
    await _client.api.auth.forgottenPassword(
      body: ForgottenRequestModel(
        email: email,
        resetUrl: resetUrl.toString(),
      ),
    );
    // will throw if not success full, so return true;
    return true;
  }

  /// Force refreshes the JWT
  ///
  /// Used to update roles
  Future<void> refreshAuth() async {
    final tokenInfo = await _client.token.reAuth();
    if (tokenInfo != null) {
      final AuthUserModel user = AuthUserModel.fromJson(tokenInfo.userMap);
      // Set the user stream to trigger auth navigator.
      _setUser(user);
    }
  }

  /// Send a reset password email.
  Future<bool> passwordReset({
    required String email,
    required String password,
    required String token,
  }) async {
    final res = await _client.api.auth.resetPassword(
      body: ResetPasswordRequestModel(
        password: password,
        email: email,
        token: token,
      ),
    );
    if (res.body != null) {
      loginWithEmail(email: email, password: password);
    }
    // will throw if not success full, so return true;
    return true;
  }

  /// Check if a given field already exists in the database.
  Future<bool> isFieldDuplicate({String? email, String? username}) async {
    final res =
        await _client.api.auth.isUnique(email: email, username: username);
    if (res.body == null) return false;
    return res.body!.exists;
  }

  /// Log a user out.
  Future<void> logout() async {
    _setUser(null);
    // locator<SettingsRepository>().reset();
    debugPrint("popScopes");
    await locator.popScopesTill("loggedIn");
    await _client.token.removeTokenInfo();
  }

  void _setUser(AuthUserModel? user) {
    _currentUser = user;
    _controller.add(user);
  }
}
