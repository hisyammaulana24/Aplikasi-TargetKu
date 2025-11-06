import 'package:fpdart/fpdart.dart';
import '../../../core/error/failures.dart';
import 'target_entity.dart'; // Sesuaikan nama file jika berbeda
import 'target_enum.dart'; // Sesuaikan nama file jika berbeda

abstract class TargetRepository {
  /// Mengambil stream dari daftar target berdasarkan statusnya.
  /// Menggunakan Stream agar UI bisa update secara otomatis saat ada data baru.
  Stream<List<Target>> watchAllTargets(TargetStatus status);

  /// Menambah atau mengupdate sebuah target di database.
  /// Mengembalikan `void` jika berhasil, atau `Failure` jika gagal.
  Future<Either<Failure, void>> saveTarget(Target target);

  /// Menghapus sebuah target dari database berdasarkan ID-nya.
  Future<Either<Failure, void>> deleteTarget(int id);
}