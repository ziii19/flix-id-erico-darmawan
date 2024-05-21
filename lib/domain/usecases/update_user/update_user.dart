import '../../../data/repositories/user_repository.dart';
import '../../entities/result.dart';
import 'update_user_param.dart';
import '../usecases.dart';

class UpdateUser implements UseCase<Result<void>, UpdateUserParam> {
  final UserRepository _userRepository;

  UpdateUser({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<void>> call(UpdateUserParam params) async {
    var result = await _userRepository.updateUser(user: params.user);

    if (result is Success) {
      return const Result.success(null);
    } else if (result is Failed) {
      return Result.failed(result.errorMessage!);
    } else {
      return const Result.failed("Unknown error");
    }
  }
}
