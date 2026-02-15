import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, void>> addTransaction({
    required String title,
    required double amount,
  });

  Future<Either<Failure, List<Transaction>>> getTransactions();
}
