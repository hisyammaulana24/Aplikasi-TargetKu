import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

// Beri nama panggilan 'db' untuk menghindari konflik nama
import '../../../core/app_database.dart' as db;
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
                  imagePath: row.imagePath,
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
            // --- INI ADALAH PERBAIKANNYA ---
            // Gunakan konstruktor default () dan bungkus SEMUA nilai dengan Value()
            db.TargetsCompanion(
              id: target.id == null
                  ? const Value.absent()
                  : Value(target.id!),
              name: Value(target.name),
              targetAmount: Value(target.targetAmount),
              imagePath: Value(target.imagePath),
              plannedAmount: Value(target.plannedAmount),
              planFrequency: Value(target.planFrequency),
              status: Value(target.status),
              createdAt: Value(target.createdAt),
              completedAt: Value(target.completedAt),
            ),
            // --- AKHIR PERBAIKAN ---
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