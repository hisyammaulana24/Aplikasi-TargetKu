// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'2fda5b6218c15359ec8eaa1efa9bb7be989286e9';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<db.AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

// ignore: deprecated_member_use
typedef AppDatabaseRef = ProviderRef<db.AppDatabase>;
String _$targetRepositoryHash() => r'dbc03080d066a3b3d6b795b475a07d9514eb1071';

/// See also [targetRepository].
@ProviderFor(targetRepository)
final targetRepositoryProvider = AutoDisposeProvider<TargetRepository>.internal(
  targetRepository,
  name: r'targetRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$targetRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

// ignore: deprecated_member_use
typedef TargetRepositoryRef = AutoDisposeProviderRef<TargetRepository>;
String _$transactionRepositoryHash() =>
    r'60a451d830fd9d4745a0f30cba22089fe7146027';

/// See also [transactionRepository].
@ProviderFor(transactionRepository)
final transactionRepositoryProvider =
    AutoDisposeProvider<TransactionRepository>.internal(
  transactionRepository,
  name: r'transactionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransactionRepositoryRef
    // ignore: deprecated_member_use
    = AutoDisposeProviderRef<TransactionRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
