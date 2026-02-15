import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/transaction/data/datasources/transaction_remote_datasource.dart';
import '../../features/transaction/data/repositories/transaction_repository_impl.dart';
import '../../features/transaction/domain/repositories/transaction_repository.dart';
import '../../features/transaction/domain/usecases/add_transaction.dart';
import '../../features/transaction/domain/usecases/get_transactions.dart';
import '../../features/transaction/presentation/cubit/transaction_cubit.dart';
import '../../services/risk_analyzer.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  sl.registerLazySingleton(() => RiskAnalyzer());

  // Data sources
  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () =>
        TransactionRemoteDataSourceImpl(firestore: FirebaseFirestore.instance),
  );

  // Repository
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => AddTransaction(sl()));
  sl.registerLazySingleton(() => GetTransactions(sl()));

  // Cubit
  sl.registerFactory(
    () => TransactionCubit(
      addTransaction: sl(),
      getTransactions: sl(),
      riskAnalyzer: sl(),
    ),
  );
}
