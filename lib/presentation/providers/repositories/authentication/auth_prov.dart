import '../../../../data/Firebase/firebase_authentication.dart';
import '../../../../data/repositories/authentication.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_prov.g.dart';

@riverpod
Authentication authentication(AuthenticationRef ref) => FirebaseAuth();
