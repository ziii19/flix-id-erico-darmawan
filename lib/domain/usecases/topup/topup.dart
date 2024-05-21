import '../../../data/repositories/transaction_repository.dart';
import '../../entities/result.dart';
import '../../entities/transaction.dart';
import '../create_transaction/create_transaction.dart';
import '../create_transaction/create_transaction_param.dart';
import 'topup_param.dart';
import '../usecases.dart';

class TopUp implements UseCase<Result<void>, TopUpParam> {
  final TransactionRepository _transactionRepository;

  TopUp({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;
  @override
  Future<Result<void>> call(TopUpParam params) async {
    CreateTransaction createTransaction =
        CreateTransaction(transactionRepository: _transactionRepository);

    int trxTime = DateTime.now().millisecondsSinceEpoch;

    var createTrxResult = await createTransaction(CreateTransactionParam(
        transaction: Transaction(
            id: 'flxtp-$trxTime-${params.userId}',
            uid: params.userId,
            title: 'Top Up',
            adminFee: 0,
            total: -params.amount,
            transactionTime: trxTime)));

    return switch (createTrxResult) {
      Success(value: _) => const Result.success(null),
      Failed(message: _) => const Result.failed("Failed to Top Up")
    };
  }
}
