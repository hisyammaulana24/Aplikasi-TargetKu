// lib/core/app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Import enum yang sudah kita buat
import 'package:aplikasi_targetku/features/target/domain/target_enum.dart';
import 'package:aplikasi_targetku/features/transaction/domain/transaction_enum.dart';

part 'app_database.g.dart'; // Akan di-generate oleh build_runner

// 1. Definisikan Tabel 'Targets'
class Targets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get targetAmount => real()();
  TextColumn get imageUrl => text().nullable()();
  RealColumn get plannedAmount => real()();
  TextColumn get planFrequency => text().map(const PlanFrequencyConverter())();
  TextColumn get status => text().map(const TargetStatusConverter())();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

// 2. Definisikan Tabel 'Transactions'
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get targetId => integer().references(Targets, #id)();
  RealColumn get amount => real()();
  TextColumn get type => text().map(const TransactionTypeConverter())();
  TextColumn get description => text().nullable()();
  DateTimeColumn get date => dateTime()();
}

// 3. Definisikan Database itu sendiri
@DriftDatabase(tables: [Targets, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

// Fungsi untuk membuka koneksi database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

// 4. Buat Type Converter untuk Enum
// Ini agar Drift bisa menyimpan Enum sebagai teks di database
class TargetStatusConverter extends TypeConverter<TargetStatus, String> {
  const TargetStatusConverter();
  @override
  TargetStatus fromSql(String fromDb) => TargetStatus.values.byName(fromDb);
  @override
  String toSql(TargetStatus value) => value.name;
}

class PlanFrequencyConverter extends TypeConverter<PlanFrequency, String> {
  const PlanFrequencyConverter();
  @override
  PlanFrequency fromSql(String fromDb) => PlanFrequency.values.byName(fromDb);
  @override
  String toSql(PlanFrequency value) => value.name;
}

class TransactionTypeConverter extends TypeConverter<TransactionType, String> {
  const TransactionTypeConverter();
  @override
  TransactionType fromSql(String fromDb) => TransactionType.values.byName(fromDb);
  @override
  String toSql(TransactionType value) => value.name;
}