import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/target/data/target_repository_impl.dart';
import '../../features/target/domain/target_repository.dart';
import '../../features/transaction/data/transaction_repository_impl.dart';
import '../../features/transaction/domain/transaction_repository.dart';
import '../app_database.dart' as db;

part 'repository_providers.g.dart'; // Jalankan build_runner setelah ini

// 1. Provider untuk instance AppDatabase
// keepAlive: true agar koneksi database tidak ditutup selama aplikasi berjalan
@Riverpod(keepAlive: true)
db.AppDatabase appDatabase(AppDatabaseRef ref) {
  return db.AppDatabase();
}

// 2. Provider untuk TargetRepository
// Riverpod akan secara otomatis menyediakan 'appDatabaseProvider' ke sini
@riverpod
TargetRepository targetRepository(TargetRepositoryRef ref) {
  return TargetRepositoryImpl(ref.watch(appDatabaseProvider));
}

// 3. Provider untuk TransactionRepository
@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  return TransactionRepositoryImpl(ref.watch(appDatabaseProvider));
}