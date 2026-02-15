import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/transaction_repository.dart';

class AddTransaction implements UseCase<void, AddTransactionParams> {
  final TransactionRepository repository;

  AddTransaction(this.repository);

  @override
  Future<Either<Failure, void>> call(AddTransactionParams params) async {
    return await repository.addTransaction(
      title: params.title,
      amount: params.amount,
    );
  }
}

class AddTransactionParams {
  final String title;
  final double amount;

  AddTransactionParams({required this.title, required this.amount});
}
