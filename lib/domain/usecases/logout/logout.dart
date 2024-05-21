import '../../../data/repositories/authentication.dart';
import '../../entities/result.dart';
import '../usecases.dart';

class Logout implements UseCase<Result<void>, void> {
  final Authentication _authentication;

  Logout({required Authentication authentication})
      : _authentication = authentication;
  @override
  Future<Result<void>> call(void _) {
    return _authentication.logout();
  }
}
