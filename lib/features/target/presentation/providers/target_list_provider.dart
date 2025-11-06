import 'package:riverpod_annotation/riverpod_annotation.dart'; // <-- TAMBAHKAN IMPORT INI

import '../../../../core/providers/repository_providers.dart';
import '../../domain/target_entity.dart';
import '../../domain/target_enum.dart';

part 'target_list_provider.g.dart';

@riverpod // Sekarang anotasi ini akan dikenali
class TargetList extends _$TargetList {
  @override
  Stream<List<Target>> build(TargetStatus status) {
    final repository = ref.watch(targetRepositoryProvider);
    return repository.watchAllTargets(status);
  }
}