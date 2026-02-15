import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<void> addTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getTransactions();
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final FirebaseFirestore firestore;

  TransactionRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    await firestore
        .collection('transactions')
        .doc(transaction.id)
        .set(transaction.toJson());
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final snapshot = await firestore
        .collection('transactions')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => TransactionModel.fromJson(doc.data()))
        .toList();
  }
}
