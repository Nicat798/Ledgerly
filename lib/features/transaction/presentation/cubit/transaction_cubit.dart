import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../services/risk_analyzer.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/get_transactions.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final AddTransaction addTransaction;
  final GetTransactions getTransactions;
  final RiskAnalyzer riskAnalyzer;

  TransactionCubit({
    required this.addTransaction,
    required this.getTransactions,
    required this.riskAnalyzer,
  }) : super(TransactionInitial());

  Future<void> loadTransactions() async {
    emit(TransactionLoading());

    final result = await getTransactions(NoParams());

    result.fold((failure) => emit(TransactionError(failure.message)), (
      transactions,
    ) {
      final updatedTransactions = transactions.map((t) {
        final score = riskAnalyzer.calculateRiskScore(t.amount);
        return Transaction(
          id: t.id,
          title: t.title,
          amount: t.amount,
          createdAt: t.createdAt,
          riskScore: score,
        );
      }).toList();

      emit(TransactionLoaded(updatedTransactions));
    });
  }

  Future<void> addNewTransaction(String title, double amount) async {
    emit(TransactionLoading());

    final result = await addTransaction(
      AddTransactionParams(title: title, amount: amount),
    );

    result.fold((failure) => emit(TransactionError(failure.message)), (_) {
      emit(TransactionAdded());
      loadTransactions();
    });
  }
}
