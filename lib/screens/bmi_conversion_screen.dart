import 'package:flutter/material.dart';

class BMIConversionScreen extends StatefulWidget {
  const BMIConversionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BMIConversionScreenState createState() => _BMIConversionScreenState();
}

class _BMIConversionScreenState extends State<BMIConversionScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double _bmiResult = 0.0;

  void _calculateBMI() {
    setState(() {
      double weight = double.tryParse(_weightController.text) ?? 0.0;
      double height = double.tryParse(_heightController.text) ?? 0.0;
      if (height > 0) {
        _bmiResult = weight / ((height / 100) * (height / 100)); // Tinggi diubah ke meter
      } else {
        _bmiResult = 0.0;
      }
    });
  }

  void _resetFields() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _bmiResult = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Berat (kg)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan berat badan",
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Tinggi (cm)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan tinggi badan",
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _calculateBMI,
                  child: const Text("GO"),
                ),
                ElevatedButton(
                  onPressed: _resetFields,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("AC"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "BMI Anda: ${_bmiResult.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
