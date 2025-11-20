import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/target_enum.dart';
import '../providers/target_list_provider.dart';
import 'target_form_screen.dart'; // <-- PENTING: Import file form yang baru dibuat
import 'target_detail_screen.dart';

class TargetListScreen extends ConsumerWidget {
  const TargetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Selamat Datang!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // TODO: Implement profile screen navigation
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'In Progress'),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.question_mark_sharp,
                  size: 100,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Belum ada target.\nBuat target impianmu sekang!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: targets.length,
          itemBuilder: (context, index) {
            final target = targets[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TargetDetailScreen(target: target),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  leading: target.imagePath != null && target.imagePath!.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(target.imagePath!)),
                        )
                      : const CircleAvatar(
                          child: Icon(Icons.savings),
                        ),
                  title: Text(target.name),
                  subtitle: Text('Rp ${target.targetAmount.toStringAsFixed(0)}'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
