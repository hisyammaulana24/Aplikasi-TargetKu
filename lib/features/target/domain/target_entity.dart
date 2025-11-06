// lib/features/target/domain/target_entity.dart

import 'package:freezed_annotation/freezed_annotation.dart';
// Path ini sudah benar
import 'package:aplikasi_targetku/features/target/domain/target_enum.dart'; 

part 'target_entity.freezed.dart';

@freezed
class Target with _$Target {
  const factory Target({
    int? id,
    required String name,
    required double targetAmount,
    String? imageUrl,
    required double plannedAmount,
    required PlanFrequency planFrequency,
    @Default(TargetStatus.inProgress) TargetStatus status,
    required DateTime createdAt,
    DateTime? completedAt,
  }) = _Target; 
}