import '../../../data/repositories/transaction_repository.dart';
import '../../entities/result.dart';
import '../../entities/transaction.dart';
import 'get_transactions_param.dart';
import '../usecases.dart';

class GetTransaction
    implements UseCase<Result<List<Transaction>>, GetTransactionsParam> {
  final TransactionRepository _transactionRepository;

  GetTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;
  @override
  Future<Result<List<Transaction>>> call(GetTransactionsParam params) async {
    var trxListResult =
        await _transactionRepository.getUserTransaction(uid: params.uid);

    return switch (trxListResult) {
      Success(value: final trxList) => Result.success(trxList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
