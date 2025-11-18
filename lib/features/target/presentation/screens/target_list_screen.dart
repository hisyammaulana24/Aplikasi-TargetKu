import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/target_enum.dart';
import '../providers/target_list_provider.dart';

// Ubah menjadi ConsumerWidget agar bisa 'listen' ke provider
class TargetListScreen extends ConsumerWidget {
  const TargetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // DefaultTabController untuk mengelola state dari TabBar
    return DefaultTabController(
      length: 2, // Kita punya 2 tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'TargetKu',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Dalam Proses'),
              Tab(text: 'Selesai'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Konten untuk tab "Dalam Proses"
            TargetListView(status: TargetStatus.inProgress),
            // Konten untuk tab "Selesai"
            TargetListView(status: TargetStatus.completed),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

// Widget terpisah untuk menampilkan daftar target
class TargetListView extends ConsumerWidget {
  final TargetStatus status;
  const TargetListView({required this.status, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 'watch' provider dengan status yang sesuai
    final targetsAsyncValue = ref.watch(targetListProvider(status));

    // Gunakan .when untuk menangani semua state: loading, error, dan data
    return targetsAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (targets) {
        // Jika tidak ada data, tampilkan pesan
        if (targets.isEmpty) {
          return Center(
            child: Text(
              'Belum ada target di sini.\nAyo buat target pertamamu!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          );
        }

        // Jika ada data, tampilkan dalam ListView
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: targets.length,
          itemBuilder: (context, index) {
            final target = targets[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12.0),
              child: ListTile(
                title: Text(target.name),
                subtitle: Text('Rp ${target.targetAmount.toStringAsFixed(0)}'),
              ),
            );
          },
        );
      },
    );
  }
}
