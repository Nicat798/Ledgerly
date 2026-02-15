import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction.dart';

enum TransactionStatus { initial, loading, success, error }

class TransactionState extends Equatable {
  final TransactionStatus status;
  final List<Transaction> transactions;
  final String? errorMessage;

  const TransactionState({
    this.status = TransactionStatus.initial,
    this.transactions = const [],
    this.errorMessage,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    List<Transaction>? transactions,
    String? errorMessage,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, transactions, errorMessage];
}
