import '../../../domain/usecases/uploadPP/uploadpp.dart';
import '../repositories/user_repo/user_repo_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upload_pp_prov.g.dart';

@riverpod
UploadPP uploadPP(UploadPPRef ref) =>
    UploadPP(userRepository: ref.watch(userRepositoryProvider));
