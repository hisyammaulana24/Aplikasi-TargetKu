// Kelas dasar untuk semua jenis kegagalan/error dalam aplikasi
abstract class Failure {
  final String message;

  const Failure(this.message);
}

// Kegagalan spesifik yang terjadi saat ada masalah dengan database
class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}