// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Target {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get targetAmount => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  double get plannedAmount => throw _privateConstructorUsedError;
  PlanFrequency get planFrequency => throw _privateConstructorUsedError;
  TargetStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TargetCopyWith<Target> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetCopyWith<$Res> {
  factory $TargetCopyWith(Target value, $Res Function(Target) then) =
      _$TargetCopyWithImpl<$Res, Target>;
  @useResult
  $Res call(
      {int? id,
      String name,
      double targetAmount,
      String? imagePath,
      double plannedAmount,
      PlanFrequency planFrequency,
      TargetStatus status,
      DateTime createdAt,
      DateTime? completedAt});
}

/// @nodoc
class _$TargetCopyWithImpl<$Res, $Val extends Target>
    implements $TargetCopyWith<$Res> {
  _$TargetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? targetAmount = null,
    Object? imagePath = freezed,
    Object? plannedAmount = null,
    Object? planFrequency = null,
    Object? status = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      targetAmount: null == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      plannedAmount: null == plannedAmount
          ? _value.plannedAmount
          : plannedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      planFrequency: null == planFrequency
          ? _value.planFrequency
          : planFrequency // ignore: cast_nullable_to_non_nullable
              as PlanFrequency,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TargetStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TargetImplCopyWith<$Res> implements $TargetCopyWith<$Res> {
  factory _$$TargetImplCopyWith(
          _$TargetImpl value, $Res Function(_$TargetImpl) then) =
      __$$TargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      double targetAmount,
      String? imagePath,
      double plannedAmount,
      PlanFrequency planFrequency,
      TargetStatus status,
      DateTime createdAt,
      DateTime? completedAt});
}

/// @nodoc
class __$$TargetImplCopyWithImpl<$Res>
    extends _$TargetCopyWithImpl<$Res, _$TargetImpl>
    implements _$$TargetImplCopyWith<$Res> {
  __$$TargetImplCopyWithImpl(
      _$TargetImpl _value, $Res Function(_$TargetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? targetAmount = null,
    Object? imagePath = freezed,
    Object? plannedAmount = null,
    Object? planFrequency = null,
    Object? status = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(_$TargetImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      targetAmount: null == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      plannedAmount: null == plannedAmount
          ? _value.plannedAmount
          : plannedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      planFrequency: null == planFrequency
          ? _value.planFrequency
          : planFrequency // ignore: cast_nullable_to_non_nullable
              as PlanFrequency,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TargetStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$TargetImpl implements _Target {
  const _$TargetImpl(
      {this.id,
      required this.name,
      required this.targetAmount,
      this.imagePath,
      required this.plannedAmount,
      required this.planFrequency,
      this.status = TargetStatus.inProgress,
      required this.createdAt,
      this.completedAt});

  @override
  final int? id;
  @override
  final String name;
  @override
  final double targetAmount;
  @override
  final String? imagePath;
  @override
  final double plannedAmount;
  @override
  final PlanFrequency planFrequency;
  @override
  @JsonKey()
  final TargetStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'Target(id: $id, name: $name, targetAmount: $targetAmount, imagePath: $imagePath, plannedAmount: $plannedAmount, planFrequency: $planFrequency, status: $status, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TargetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.plannedAmount, plannedAmount) ||
                other.plannedAmount == plannedAmount) &&
            (identical(other.planFrequency, planFrequency) ||
                other.planFrequency == planFrequency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, targetAmount,
      imagePath, plannedAmount, planFrequency, status, createdAt, completedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetImplCopyWith<_$TargetImpl> get copyWith =>
      __$$TargetImplCopyWithImpl<_$TargetImpl>(this, _$identity);
}

abstract class _Target implements Target {
  const factory _Target(
      {final int? id,
      required final String name,
      required final double targetAmount,
      final String? imagePath,
      required final double plannedAmount,
      required final PlanFrequency planFrequency,
      final TargetStatus status,
      required final DateTime createdAt,
      final DateTime? completedAt}) = _$TargetImpl;

  @override
  int? get id;
  @override
  String get name;
  @override
  double get targetAmount;
  @override
  String? get imagePath;
  @override
  double get plannedAmount;
  @override
  PlanFrequency get planFrequency;
  @override
  TargetStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get completedAt;
  @override
  @JsonKey(ignore: true)
  _$$TargetImplCopyWith<_$TargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
