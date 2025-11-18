import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart'; 
import '../../domain/target_entity.dart';
import '../../domain/target_enum.dart';

class TargetFormScreen extends ConsumerStatefulWidget {
  const TargetFormScreen({super.key});

  @override
  ConsumerState<TargetFormScreen> createState() => _TargetFormScreenState();
}

class _TargetFormScreenState extends ConsumerState<TargetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _plannedAmountController = TextEditingController();
  
  PlanFrequency _selectedFrequency = PlanFrequency.daily;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _plannedAmountController.dispose();
    super.dispose();
  }

  Future<void> _saveTarget() async {
    if (_formKey.currentState!.validate()) {
      try {
        // PERBAIKAN: Tambahkan try-catch untuk menangkap error parsing angka
        final double targetAmount = double.parse(_amountController.text);
        final double plannedAmount = double.parse(_plannedAmountController.text);

        final newTarget = Target(
          // ID akan diatur oleh database karena kolom id menggunakan autoIncrement()
          // Jadi kita set id ke null agar database bisa membuat ID baru
          id: null,
          
          name: _nameController.text,
          targetAmount: targetAmount,
          plannedAmount: plannedAmount,
          planFrequency: _selectedFrequency,
          createdAt: DateTime.now(),
          status: TargetStatus.inProgress,
          // completedAt boleh null, jadi tidak perlu diisi
        );

        // Simpan ke database lewat provider
        final repository = ref.read(targetRepositoryProvider);
        final result = await repository.saveTarget(newTarget);

        result.fold(
          (failure) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gagal: ${failure.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          (_) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Target berhasil disimpan!'),
                  backgroundColor: Colors.teal,
                ),
              );
              Navigator.of(context).pop(); // Kembali ke halaman list
            }
          },
        );
      } catch (e) {
        // Menangani jika user memasukkan teks yang bukan angka
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Error input: Pastikan nominal angka valid ($e)')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Target Baru')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Target',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Total Harga Barang (Rp)',
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: 5000000 (tanpa titik)',
                ),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _plannedAmountController,
                decoration: const InputDecoration(
                  labelText: 'Nominal Nabung Rutin (Rp)',
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: 50000 (tanpa titik)',
                ),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<PlanFrequency>(
                value: _selectedFrequency,
                decoration: const InputDecoration(
                  labelText: 'Frekuensi Nabung',
                  border: OutlineInputBorder(),
                ),
                items: PlanFrequency.values.map((f) {
                  return DropdownMenuItem(
                    value: f, 
                    child: Text(f.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedFrequency = val!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveTarget,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Simpan Target'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}