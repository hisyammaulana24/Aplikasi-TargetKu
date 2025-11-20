import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/repository_providers.dart';
import '../../../../core/utils/currency_input_formatter.dart';
import '../../../transaction/domain/transaction_entity.dart';
import '../../../transaction/domain/transaction_enum.dart';
import '../../domain/target_entity.dart';

class TransactionFormScreen extends ConsumerStatefulWidget {
  final Target target;

  const TransactionFormScreen({super.key, required this.target});

  @override
  ConsumerState<TransactionFormScreen> createState() =>
      _TransactionFormScreenState();
}

class _TransactionFormScreenState extends ConsumerState<TransactionFormScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pemasukan'),
            Tab(text: 'Pengeluaran'),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildTargetHeader(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTransactionForm(TransactionType.increase),
                _buildTransactionForm(TransactionType.decrease),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetHeader() {
    // Dummy data for now, replace with real data later
    const terkumpul = 6750000;
    final sisa = widget.target.targetAmount - terkumpul;
    final progress = terkumpul / widget.target.targetAmount;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Placeholder for image
              Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.target.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp ${NumberFormat.decimalPattern('id').format(widget.target.targetAmount)}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 4),
                    Text('Progress: ${(progress * 100).toStringAsFixed(0)}%'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // TODO: Add other details like Terkumpul, Sisa, etc.
        ],
      ),
    );
  }

  Widget _buildTransactionForm(TransactionType type) {
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();

    void saveTransaction() async {
      final amount = double.tryParse(amountController.text.replaceAll('.', ''));
      if (amount == null) {
        // Show error
        return;
      }

      final newTransaction = Transaction(
        targetId: widget.target.id!,
        amount: amount,
        type: type,
        description: descriptionController.text,
        date: DateTime.now(),
      );

      final result = await ref
          .read(transactionRepositoryProvider)
          .saveTransaction(newTransaction);

      result.fold(
        (l) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.message))),
        (r) => Navigator.of(context).pop(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Nominal (Rp)'),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Keterangan (Opsional)'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: saveTransaction,
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
