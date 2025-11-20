import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/target_entity.dart';
import 'transaction_form_screen.dart';

class TargetDetailScreen extends ConsumerWidget {
  final Target target;

  const TargetDetailScreen({super.key, required this.target});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dummy progress for now
    const double currentProgress = 0.45; 
    final progressPercentage = (currentProgress * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Target'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (target.imagePath != null && target.imagePath!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(target.imagePath!),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image, size: 80, color: Colors.grey),
              ),
            const SizedBox(height: 24),
            Text(
              target.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Rp ${target.targetAmount.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),
            LinearProgressIndicator(
              value: currentProgress,
              minHeight: 12,
              borderRadius: BorderRadius.circular(6),
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Progress: $progressPercentage%',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            const Spacer(), // Use Spacer to push the toggles to the bottom
            SwitchListTile(
              title: const Text('Aktifkan Pengingat'),
              value: false, // Dummy value
              onChanged: (bool value) {
                // TODO: Implement reminder logic
              },
              secondary: const Icon(Icons.notifications_active_outlined),
            ),
            SwitchListTile(
              title: const Text('Aktifkan Premium (Opsional)'),
              subtitle: const Text('Fitur eksklusif untuk mencapai target lebih cepat!'),
              value: false, // Dummy value
              onChanged: (bool value) {
                // TODO: Implement premium feature logic
              },
              secondary: const Icon(Icons.star_border_outlined),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionFormScreen(target: target),
            ),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}