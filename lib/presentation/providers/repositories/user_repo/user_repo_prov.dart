import '../../../../data/Firebase/firebase_user_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repo_prov.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) => FirebaseUserRepo();
