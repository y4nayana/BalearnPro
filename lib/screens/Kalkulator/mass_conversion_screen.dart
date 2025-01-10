import 'package:flutter/material.dart';

class MassConversionScreen extends StatefulWidget {
  const MassConversionScreen({super.key});

  @override
  _MassConversionScreenState createState() => _MassConversionScreenState();
}

class _MassConversionScreenState extends State<MassConversionScreen> {
  String _inputValue = ""; // Untuk menyimpan nilai input dari keyboard khusus
  double _convertedValue = 0.0;
  String _selectedUnitFrom = "Kilogram";
  String _selectedUnitTo = "Gram";

  final Map<String, double> _conversionRates = {
    "Kilogram to Gram": 1000,
    "Kilogram to Ton": 0.001,
    "Kilogram to Milligram": 1000000,
    "Kilogram to Pound": 2.20462,
    "Gram to Kilogram": 0.001,
    "Gram to Ton": 0.000001,
    "Gram to Milligram": 1000,
    "Gram to Pound": 0.00220462,
    "Ton to Kilogram": 1000,
    "Ton to Gram": 1000000,
    "Ton to Milligram": 1000000000,
    "Ton to Pound": 2204.62,
    "Milligram to Kilogram": 0.000001,
    "Milligram to Gram": 0.001,
    "Milligram to Ton": 0.000000001,
    "Milligram to Pound": 0.00000220462,
    "Pound to Kilogram": 0.453592,
    "Pound to Gram": 453.592,
    "Pound to Ton": 0.000453592,
    "Pound to Milligram": 453592,
    "Kilogram to Kilogram": 1,
    "Gram to Gram": 1,
    "Ton to Ton": 1,
    "Milligram to Milligram": 1,
    "Pound to Pound": 1,
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputValue) ?? 0.0;
      String conversionKey = "$_selectedUnitFrom to $_selectedUnitTo";
      _convertedValue = input * (_conversionRates[conversionKey] ?? 1.0);
    });
  }

  void _clearInput() {
    setState(() {
      _inputValue = "";
      _convertedValue = 0.0;
    });
  }

  void _updateInput(String value) {
    setState(() {
      if (value == "." && _inputValue.contains(".")) return; // Hindari koma ganda
      _inputValue += value;
    });
    _convert();
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
                    DropdownMenuItem(value: "Kilogram", child: Text("Kilogram")),
                    DropdownMenuItem(value: "Gram", child: Text("Gram")),
                    DropdownMenuItem(value: "Ton", child: Text("Ton")),
                    DropdownMenuItem(value: "Milligram", child: Text("Milligram")),
                    DropdownMenuItem(value: "Pound", child: Text("Pound")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitFrom = value!;
                    });
                    _convert();
                  },
                ),
                const Icon(Icons.swap_horiz),
                DropdownButton<String>(
                  value: _selectedUnitTo,
                  items: const [
                    DropdownMenuItem(value: "Kilogram", child: Text("Kilogram")),
                    DropdownMenuItem(value: "Gram", child: Text("Gram")),
                    DropdownMenuItem(value: "Ton", child: Text("Ton")),
                    DropdownMenuItem(value: "Milligram", child: Text("Milligram")),
                    DropdownMenuItem(value: "Pound", child: Text("Pound")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitTo = value!;
                    });
                    _convert();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              readOnly: true, // Tidak dapat diketik langsung
              controller: TextEditingController(text: _inputValue),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Masukkan nilai",
                suffixText: _selectedUnitFrom, // Tambahkan unit di samping input
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Hasil: ${_convertedValue.toStringAsFixed(3)} $_selectedUnitTo",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        _buildKeypadRow(["7", "8", "9"]),
        const SizedBox(height: 8),
        _buildKeypadRow(["4", "5", "6"]),
        const SizedBox(height: 8),
        _buildKeypadRow(["1", "2", "3"]),
        const SizedBox(height: 8),
        _buildKeypadRow(["0", ".", "AC"]),
      ],
    );
  }

  Widget _buildKeypadRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return GestureDetector(
          onTap: () {
            if (button == "AC") {
              _clearInput();
            } else {
              _updateInput(button);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: button == "AC" ? Colors.orange : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Text(
              button,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: button == "AC" ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
