import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Pastikan package intl ada di pubspec.yaml
import '../../../core/providers/repository_providers.dart';
import '../../domain/transaction_entity.dart';
import '../../domain/transaction_enum.dart';

class TransactionFormScreen extends ConsumerStatefulWidget {
  final int targetId; // ID Target yang akan dikurangi saldonya (Pengeluaran)

  const TransactionFormScreen({super.key, required this.targetId});

  @override
  ConsumerState<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends ConsumerState<TransactionFormScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedCategory = 'Makan'; // Default category

  // Daftar Kategori (Icon, Nama, Warna Background)
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.fastfood, 'label': 'Makan', 'color': Colors.orange.shade100, 'iconColor': Colors.orange},
    {'icon': Icons.icecream, 'label': 'Jajan', 'color': Colors.pink.shade100, 'iconColor': Colors.pink},
    {'icon': Icons.directions_bus, 'label': 'Transport', 'color': Colors.blue.shade100, 'iconColor': Colors.blue},
    {'icon': Icons.shopping_bag, 'label': 'Belanja', 'color': Colors.purple.shade100, 'iconColor': Colors.purple},
    {'icon': Icons.sports_esports, 'label': 'Hiburan', 'color': Colors.green.shade100, 'iconColor': Colors.green},
    {'icon': Icons.receipt_long, 'label': 'Tagihan', 'color': Colors.red.shade100, 'iconColor': Colors.red},
    {'icon': Icons.school, 'label': 'Pendidikan', 'color': Colors.teal.shade100, 'iconColor': Colors.teal},
    {'icon': Icons.more_horiz, 'label': 'Lainnya', 'color': Colors.grey.shade200, 'iconColor': Colors.grey},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveTransaction() async {
    if (_amountController.text.isEmpty) return;

    final amount = double.tryParse(_amountController.text) ?? 0;
    
    // Gabungkan Kategori dan Catatan ke dalam deskripsi
    // Format: "Kategori - Catatan User"
    final fullDescription = "$_selectedCategory - ${_noteController.text}";

    // Gabungkan Date dan Time
    final dateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final newTransaction = Transaction(
      targetId: widget.targetId,
      amount: amount,
      type: TransactionType.expense, // Tipe Pengeluaran
      description: fullDescription,
      date: dateTime,
    );

    final repository = ref.read(transactionRepositoryProvider);
    final result = await repository.saveTransaction(newTransaction);

    if (!mounted) return;

    result.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(failure.message)),
      ),
      (_) => Navigator.of(context).pop(), // Kembali setelah simpan
    );
  }

  @override
  Widget build(BuildContext context) {
    // Warna utama (Hijau Teal seperti di gambar)
    const primaryColor = Color(0xFF00BFA5); 

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pengeluaran',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- BAGIAN HEADER (INPUT NOMINAL) ---
          Container(
            color: primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nominal',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Row(
                  children: [
                    const Text(
                      'Rp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0',
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ),
                    const Icon(Icons.calculate_outlined, color: Colors.white, size: 30),
                  ],
                ),
              ],
            ),
          ),

          // --- BAGIAN ISI (KATEGORI & INPUT LAIN) ---
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kategori',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  
                  // Grid Kategori
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final isSelected = _selectedCategory == cat['label'];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = cat['label'];
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : cat['color'],
                                shape: BoxShape.circle,
                                border: isSelected 
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                                boxShadow: isSelected 
                                  ? [BoxShadow(color: primaryColor.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))] 
                                  : null,
                              ),
                              child: Icon(
                                cat['icon'],
                                color: isSelected ? Colors.white : cat['iconColor'],
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              cat['label'],
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? primaryColor : Colors.black87,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Row Input Tanggal, Waktu, Catatan
                  Row(
                    children: [
                      // Tombol Tanggal
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Tombol Waktu
                      InkWell(
                        onTap: () => _selectTime(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time, size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(_selectedTime.format(context)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Input Catatan
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      hintText: 'Tambah catatan...',
                      prefixIcon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _saveTransaction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}