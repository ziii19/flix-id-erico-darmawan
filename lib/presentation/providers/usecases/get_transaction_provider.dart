import '../../../domain/usecases/get_transactions/get_transactions.dart';
import '../repositories/transaction_repo/transaction_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_transaction_provider.g.dart';

@riverpod
GetTransaction getTransaction(GetTransactionRef ref) => GetTransaction(
    transactionRepository: ref.watch(transactionRepositoryProvider));
