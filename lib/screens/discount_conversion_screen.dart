import 'package:flutter/material.dart';

class DiscountConversionScreen extends StatelessWidget {
  const DiscountConversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konversi Diskon"),
      ),
      body: const Center(
        child: Text("Halaman Konversi Diskon"),
      ),
    );
  }
}
