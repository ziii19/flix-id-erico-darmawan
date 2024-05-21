import '../../../data/repositories/user_repository.dart';
import '../../entities/result.dart';
import '../../entities/user.dart';
import 'uploadpp_param.dart';
import '../usecases.dart';

class UploadPP implements UseCase<Result<User>, UploadPpParam> {
  final UserRepository _userRepository;

  UploadPP({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<User>> call(UploadPpParam params) =>
      _userRepository.uploadPP(user: params.user, imageFile: params.imageFile);
}
