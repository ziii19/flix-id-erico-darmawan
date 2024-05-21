import '../../../domain/usecases/topup/topup.dart';
import '../repositories/transaction_repo/transaction_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topup_prov.g.dart';

@riverpod
TopUp topUp(TopUpRef ref) =>
    TopUp(transactionRepository: ref.watch(transactionRepositoryProvider));
