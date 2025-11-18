import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/target_enum.dart';
import '../providers/target_list_provider.dart';
import 'target_form_screen.dart'; // <-- PENTING: Import file form yang baru dibuat

class TargetListScreen extends ConsumerWidget {
  const TargetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
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
            TargetListView(status: TargetStatus.inProgress),
            TargetListView(status: TargetStatus.completed),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // <-- PERBAIKAN DI SINI: Navigasi ke TargetFormScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TargetFormScreen(),
              ),
            );
          },
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

// Widget TargetListView tetap sama seperti sebelumnya
class TargetListView extends ConsumerWidget {
  final TargetStatus status;
  const TargetListView({required this.status, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetsAsyncValue = ref.watch(targetListProvider(status));

    return targetsAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (targets) {
        if (targets.isEmpty) {
          return Center(
            child: Text(
              'Belum ada target di sini.\nAyo buat target pertamamu!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          );
        }

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