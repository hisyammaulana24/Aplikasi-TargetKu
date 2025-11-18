import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/app_database.dart' as db;
import '../../../core/error/failures.dart';
import '../domain/transaction_entity.dart';
import '../domain/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final db.AppDatabase _database;

  TransactionRepositoryImpl(this._database);

  @override
  Stream<List<Transaction>> watchTransactionsForTarget(int targetId) {
    return (_database.select(_database.transactions)
          ..where((tbl) => tbl.targetId.equals(targetId))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])) // Sekarang OrderingTerm & OrderingMode dikenali
        .watch()
        .map((rows) => rows
            .map((row) => Transaction( // Ini adalah Transaction dari domain (Freezed)
                  id: row.id,
                  targetId: row.targetId,
                  amount: row.amount,
                  type: row.type,
                  description: row.description,
                  date: row.date,
                ))
            .toList());
  }

   @override
  Future<Either<Failure, void>> saveTransaction(Transaction transaction) async {
    try {
      await _database.into(_database.transactions).insert(
            db.TransactionsCompanion( 
              targetId: Value(transaction.targetId),
              amount: Value(transaction.amount),
              type: Value(transaction.type),
              description: Value(transaction.description), // Sekarang ini valid
              date: Value(transaction.date),
            ),
          );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Gagal menyimpan transaksi: ${e.toString()}'));
    }
  }
}