// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$targetListHash() => r'429f85a5f36487eb40fb2f05ed596d08cec1b614';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TargetList
    extends BuildlessAutoDisposeStreamNotifier<List<Target>> {
  late final TargetStatus status;

  Stream<List<Target>> build(
    TargetStatus status,
  );
}

/// See also [TargetList].
@ProviderFor(TargetList)
const targetListProvider = TargetListFamily();

/// See also [TargetList].
class TargetListFamily extends Family<AsyncValue<List<Target>>> {
  /// See also [TargetList].
  const TargetListFamily();

  /// See also [TargetList].
  TargetListProvider call(
    TargetStatus status,
  ) {
    return TargetListProvider(
      status,
    );
  }

  @override
  TargetListProvider getProviderOverride(
    covariant TargetListProvider provider,
  ) {
    return call(
      provider.status,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'targetListProvider';
}

/// See also [TargetList].
class TargetListProvider
    extends AutoDisposeStreamNotifierProviderImpl<TargetList, List<Target>> {
  /// See also [TargetList].
  TargetListProvider(
    TargetStatus status,
  ) : this._internal(
          () => TargetList()..status = status,
          from: targetListProvider,
          name: r'targetListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$targetListHash,
          dependencies: TargetListFamily._dependencies,
          allTransitiveDependencies:
              TargetListFamily._allTransitiveDependencies,
          status: status,
        );

  TargetListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final TargetStatus status;

  @override
  Stream<List<Target>> runNotifierBuild(
    covariant TargetList notifier,
  ) {
    return notifier.build(
      status,
    );
  }

  @override
  Override overrideWith(TargetList Function() create) {
    return ProviderOverride(
      origin: this,
      override: TargetListProvider._internal(
        () => create()..status = status,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<TargetList, List<Target>>
      createElement() {
    return _TargetListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TargetListProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TargetListRef on AutoDisposeStreamNotifierProviderRef<List<Target>> {
  /// The parameter `status` of this provider.
  TargetStatus get status;
}

class _TargetListProviderElement
    extends AutoDisposeStreamNotifierProviderElement<TargetList, List<Target>>
    with TargetListRef {
  _TargetListProviderElement(super.provider);

  @override
  TargetStatus get status => (origin as TargetListProvider).status;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
