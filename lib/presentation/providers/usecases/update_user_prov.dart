import '../../../domain/usecases/update_user/update_user.dart';
import '../repositories/user_repo/user_repo_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_user_prov.g.dart';

@riverpod
UpdateUser updateUser(UpdateUserRef ref) =>
    UpdateUser(userRepository: ref.watch(userRepositoryProvider));
