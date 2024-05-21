import '../../../domain/usecases/login/login.dart';
import '../repositories/authentication/auth_prov.dart';
import '../repositories/user_repo/user_repo_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_prov.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
