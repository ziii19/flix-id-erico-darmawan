import '../../../domain/usecases/logout/logout.dart';
import '../repositories/authentication/auth_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_prov.g.dart';

@riverpod
Logout logout(LogoutRef ref) =>
    Logout(authentication: ref.watch(authenticationProvider));
