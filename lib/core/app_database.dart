import 'package:drift/drift.dart';
import 'package:aplikasi_targetku/features/target/domain/target_enum.dart';
import 'package:aplikasi_targetku/features/transaction/domain/transaction_enum.dart';

import 'connection/stub.dart'
    if (dart.library.io) 'connection/native.dart'
    if (dart.library.html) 'connection/web.dart';

part 'app_database.g.dart'; // Akan di-generate oleh build_runner

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

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get targetId => integer().references(Targets, #id)();
  RealColumn get amount => real()();
  TextColumn get type => text().map(const TransactionTypeConverter())();
  TextColumn get description => text().nullable()();
  DateTimeColumn get date => dateTime()();
}

@DriftDatabase(tables: [Targets, Transactions])
class AppDatabase extends _$AppDatabase {
  // --- UBAH KONSTRUKTOR INI ---
  AppDatabase() : super(openConnection()); // <-- Panggil fungsi dari import kondisional

  @override
  int get schemaVersion => 1;
}

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