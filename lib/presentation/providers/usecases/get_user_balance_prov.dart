import '../../../domain/usecases/get_user_balance/get_user_balance.dart';
import '../repositories/user_repo/user_repo_prov.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_user_balance_prov.g.dart';

@riverpod
GetUserBalance getUserBalance(GetUserBalanceRef ref) =>
    GetUserBalance(userRepository: ref.watch(userRepositoryProvider));
