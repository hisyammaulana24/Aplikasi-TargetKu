import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../../../core/providers/repository_providers.dart';
import '../../../../core/utils/currency_input_formatter.dart';
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
  File? _image;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _plannedAmountController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
      setState(() {
        _image = savedImage;
      });
    }
  }

  Future<void> _saveTarget() async {
    if (_formKey.currentState!.validate()) {
      try {
        final double targetAmount = double.parse(_amountController.text.replaceAll('.', ''));
        final double plannedAmount =
            double.parse(_plannedAmountController.text.replaceAll('.', ''));

        final newTarget = Target(
          id: null,
          name: _nameController.text,
          targetAmount: targetAmount,
          plannedAmount: plannedAmount,
          planFrequency: _selectedFrequency,
          createdAt: DateTime.now(),
          status: TargetStatus.inProgress,
          imagePath: _image?.path, // Simpan path gambar
        );

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
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Error input: Pastikan nominal angka valid ($e)')),
          );
        }
      }
    }
  }

  String _getFrequencyText(PlanFrequency frequency) {
    switch (frequency) {
      case PlanFrequency.daily:
        return 'Harian';
      case PlanFrequency.weekly:
        return 'Mingguan';
      case PlanFrequency.monthly:
        return 'Bulanan';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Target Baru'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Target',
                ),
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Target (Rp)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              const Text(
                'Gambar Target (Opsional)',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                      : const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<PlanFrequency>(
                value: _selectedFrequency,
                decoration: const InputDecoration(
                  labelText: 'Frekuensi Nabung',
                ),
                items: PlanFrequency.values.map((f) {
                  return DropdownMenuItem(
                    value: f,
                    child: Text(_getFrequencyText(f)),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedFrequency = val!),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _plannedAmountController,
                decoration: const InputDecoration(
                  labelText: 'Nominal Rencana Nabung (Rp)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveTarget,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'SIMPAN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
