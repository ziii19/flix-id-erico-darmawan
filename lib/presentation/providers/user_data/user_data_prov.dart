import 'dart:io';

import '../../../domain/entities/result.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import '../../../domain/usecases/login/login.dart';
import '../../../domain/usecases/logout/logout.dart';
import '../../../domain/usecases/register/register.dart';
import '../../../domain/usecases/register/register_param.dart';
import '../../../domain/usecases/topup/topup.dart';
import '../../../domain/usecases/topup/topup_param.dart';
import '../../../domain/usecases/uploadPP/uploadpp.dart';
import '../../../domain/usecases/uploadPP/uploadpp_param.dart';
import '../movie/now_playing_prov.dart';
import '../movie/upcoming_prov.dart';
import '../transaction_data/transaction_data_prov.dart';
import '../usecases/get_logged_in_user_prov.dart';
import '../usecases/login_prov.dart';
import '../usecases/logout_prov.dart';
import '../usecases/register_prov.dart';
import '../usecases/topup_prov.dart';
import '../usecases/upload_pp_prov.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_prov.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(value: final user):
        _getMovies();
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var result = await login(LoginParams(email: email, password: password));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password,
      String? imageUrl}) async {
    Register register = ref.read(registerProvider);

    var result = await register(RegisterParam(
        name: name, email: email, password: password, photoUrl: imageUrl));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var result = await getLoggedInUser(null);

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }
  // Future<void> refreshUserData() async {
  //   GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

  //   var result = await getLoggedInUser(null);

  //   if (result.isSuccess) {
  //     // Menggunakan switch atau metode isSuccess untuk mengecek keberhasilan
  //     state = AsyncData(result.resultValue);
  //   }
  // }

  Future<void> logout() async {
    Logout logout = ref.read(logoutProvider);
    var result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topup(int amount) async {
    TopUp topUp = ref.read(topUpProvider);

    String? userId = state.valueOrNull?.uid;

    if (userId != null) {
      var result = await topUp(TopUpParam(amount: amount, userId: userId));

      if (result.isSuccess) {
        await refreshUserData();
        await ref
            .read(transactionDataProvider.notifier)
            .refreshTransactionData();
      }
    }
  }

  Future<void> uploadPP({required User user, required File imageFile}) async {
    UploadPP uploadPP = ref.read(uploadPPProvider);

    var result = uploadPP(UploadPpParam(imageFile: imageFile, user: user));

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProvider.notifier).getMovies();
    ref.read(upcomingProvider.notifier).getMovies();
  }
}
