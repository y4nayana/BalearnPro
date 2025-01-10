import 'package:flutter/material.dart';

class DataConversionScreen extends StatefulWidget {
  const DataConversionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DataConversionScreenState createState() => _DataConversionScreenState();
}

class _DataConversionScreenState extends State<DataConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  double _convertedValue = 0.0;
  String _selectedUnitFrom = "MB";
  String _selectedUnitTo = "KB";

  final Map<String, double> _conversionRates = {
    "MB to KB": 1024,
    "KB to MB": 0.0009765625,
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;
      String conversionKey = "$_selectedUnitFrom to $_selectedUnitTo";
      _convertedValue = input * (_conversionRates[conversionKey] ?? 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konversi Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Masukkan Nilai",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan nilai untuk konversi",
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedUnitFrom,
                  items: const [
                    DropdownMenuItem(value: "MB", child: Text("Megabita")),
                    DropdownMenuItem(value: "KB", child: Text("Kilobita")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitFrom = value!;
                    });
                  },
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _selectedUnitTo,
                  items: const [
                    DropdownMenuItem(value: "MB", child: Text("Megabita")),
                    DropdownMenuItem(value: "KB", child: Text("Kilobita")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitTo = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: const Text("Konversi"),
            ),
            const SizedBox(height: 16),
            Text(
              "Hasil: $_convertedValue $_selectedUnitTo",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
