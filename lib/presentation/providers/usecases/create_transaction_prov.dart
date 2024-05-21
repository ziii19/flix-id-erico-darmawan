import '../../../domain/usecases/create_transaction/create_transaction.dart';
import '../repositories/transaction_repo/transaction_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_transaction_prov.g.dart';

@riverpod
CreateTransaction createTransaction(CreateTransactionRef ref) =>
    CreateTransaction(
        transactionRepository: ref.watch(transactionRepositoryProvider));
