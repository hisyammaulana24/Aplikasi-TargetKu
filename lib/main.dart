import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/target/presentation/screens/target_list_screen.dart'; // Kita akan buat file ini

void main() {
  runApp(
    // ProviderScope adalah widget yang akan menyimpan state dari semua provider kita.
    // Ini harus berada di paling atas dari widget tree.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TargetKu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Poppins', // Contoh jika Anda ingin menggunakan font custom
      ),
      home: const TargetListScreen(), // Halaman utama kita
    );
  }
}