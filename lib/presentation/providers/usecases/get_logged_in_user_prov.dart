import '../../../domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import '../repositories/authentication/auth_prov.dart';
import '../repositories/user_repo/user_repo_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user_prov.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
