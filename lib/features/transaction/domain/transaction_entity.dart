// lib/features/transaction/domain/transaction_entity.dart

import 'package:freezed_annotation/freezed_annotation.dart';
// Path ini sudah benar
import 'package:aplikasi_targetku/features/transaction/domain/transaction_enum.dart'; 

part 'transaction_entity.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    int? id,
    required int targetId,
    required double amount,
    required TransactionType type,
    String? description,
    required DateTime date,
  }) = _Transaction; 
}