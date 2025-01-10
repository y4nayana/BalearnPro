import 'package:flutter/material.dart';

class MassConversionScreen extends StatefulWidget {
  const MassConversionScreen({super.key});

  @override
  _MassConversionScreenState createState() => _MassConversionScreenState();
}

class _MassConversionScreenState extends State<MassConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  double _convertedValue = 0.0;
  String _selectedUnitFrom = "kg";
  String _selectedUnitTo = "g";

  final Map<String, double> _conversionRates = {
    "kg to g": 1000,
    "g to kg": 0.001,
    // Tambahkan konversi lainnya jika diperlukan
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;
      String conversionKey = "$_selectedUnitFrom to $_selectedUnitTo";
      _convertedValue = input * (_conversionRates[conversionKey] ?? 1.0);
    });
  }

  void _clearInput() {
    setState(() {
      _inputController.clear();
      _convertedValue = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Massa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedUnitFrom,
                  items: const [
                    DropdownMenuItem(value: "kg", child: Text("Kilogram")),
                    DropdownMenuItem(value: "g", child: Text("Gram")),
                    // Tambahkan opsi unit lainnya jika diperlukan
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitFrom = value!;
                      _convert();
                    });
                  },
                ),
                const Icon(Icons.swap_horiz),
                DropdownButton<String>(
                  value: _selectedUnitTo,
                  items: const [
                    DropdownMenuItem(value: "kg", child: Text("Kilogram")),
                    DropdownMenuItem(value: "g", child: Text("Gram")),
                    // Tambahkan opsi unit lainnya jika diperlukan
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitTo = value!;
                      _convert();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Masukkan nilai",
                    ),
                    onChanged: (value) {
                      _convert();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "${_convertedValue.toStringAsFixed(3)} $_selectedUnitTo",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  ...List.generate(9, (index) {
                    return _buildKeyButton((index + 1).toString());
                  }),
                  _buildKeyButton("0"),
                  _buildKeyButton("."),
                  _buildActionKey("AC", _clearInput, isAction: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyButton(String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _inputController.text += label;
          _convert();
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActionKey(String label, VoidCallback onPressed, {bool isAction = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isAction ? Colors.orange : Colors.white,
        foregroundColor: isAction ? Colors.white : Colors.black,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
