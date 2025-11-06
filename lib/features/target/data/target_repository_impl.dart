import 'package:drift/drift.dart'; // <-- 1. TAMBAHKAN IMPORT INI
import 'package:fpdart/fpdart.dart';

// Beri nama panggilan 'db' untuk menghindari konflik nama
import '../../../core/app_database.dart' as db; // <-- 2. TAMBAHKAN 'as db'
import '../../../core/error/failures.dart';
import '../domain/target_entity.dart';
import '../domain/target_enum.dart';
import '../domain/target_repository.dart';

class TargetRepositoryImpl implements TargetRepository {
  // Gunakan tipe data dengan prefix 'db'
  final db.AppDatabase _database; 

  TargetRepositoryImpl(this._database);

  @override
  Stream<List<Target>> watchAllTargets(TargetStatus status) {
    // Di sini tidak perlu prefix karena Drift sudah pintar membedakannya
    return (_database.select(_database.targets)
          ..where((tbl) => tbl.status.equalsValue(status)))
        .watch()
        .map((rows) => rows
            .map((row) => Target( // Ini adalah Target dari domain (Freezed)
                  id: row.id,
                  name: row.name,
                  targetAmount: row.targetAmount,
                  imageUrl: row.imageUrl,
                  plannedAmount: row.plannedAmount,
                  planFrequency: row.planFrequency,
                  status: row.status,
                  createdAt: row.createdAt,
                  completedAt: row.completedAt,
                ))
            .toList());
  }

  @override
  Future<Either<Failure, void>> saveTarget(Target target) async {
    try {
      await _database.into(_database.targets).insertOnConflictUpdate(
            db.TargetsCompanion.insert(
              // Panggil Value secara LANGSUNG tanpa prefix 'db.'
              id: target.id == null ? const Value.absent() : Value(target.id!), // <-- PERBAIKI DI SINI
              name: target.name,
              targetAmount: target.targetAmount,
              imageUrl: Value(target.imageUrl), // <-- PERBAIKI DI SINI
              plannedAmount: target.plannedAmount,
              planFrequency: target.planFrequency,
              status: target.status,
              createdAt: target.createdAt,
              completedAt: Value(target.completedAt), // <-- PERBAIKI DI SINI
            ),
          );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Gagal menyimpan target: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTarget(int id) async {
    try {
      await (_database.delete(_database.targets)..where((tbl) => tbl.id.equals(id))).go();
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Gagal menghapus target: ${e.toString()}'));
    }
  }
}