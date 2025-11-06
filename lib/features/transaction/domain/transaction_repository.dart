import 'package:fpdart/fpdart.dart';
import '../../../core/error/failures.dart';
import 'transaction_entity.dart'; // Sesuaikan nama file jika berbeda

abstract class TransactionRepository {
  /// Mengambil stream dari semua transaksi yang terkait dengan satu targetId.
  Stream<List<Transaction>> watchTransactionsForTarget(int targetId);

  /// Menambah transaksi baru ke database.
  Future<Either<Failure, void>> saveTransaction(Transaction transaction);
}