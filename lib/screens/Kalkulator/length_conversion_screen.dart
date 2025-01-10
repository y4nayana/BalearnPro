import 'package:flutter/material.dart';

class LengthConversionScreen extends StatefulWidget {
  const LengthConversionScreen({Key? key}) : super(key: key);

  @override
  State<LengthConversionScreen> createState() => _LengthConversionScreenState();
}

class _LengthConversionScreenState extends State<LengthConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedFromUnit = "m";
  String _selectedToUnit = "cm";
  double _convertedValue = 0.0;

  final Map<String, double> lengthConversionRates = {
    "m": 1.0,
    "cm": 100.0,
    "mm": 1000.0,
    "km": 0.001,
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;
      double fromRate = lengthConversionRates[_selectedFromUnit]!;
      double toRate = lengthConversionRates[_selectedToUnit]!;
      _convertedValue = input * (toRate / fromRate);
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
        title: const Text("Panjang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDropdown(_selectedFromUnit, (value) {
                  setState(() {
                    _selectedFromUnit = value!;
                    _convert();
                  });
                }),
                const Icon(Icons.arrow_downward),
                _buildDropdown(_selectedToUnit, (value) {
                  setState(() {
                    _selectedToUnit = value!;
                    _convert();
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan nilai panjang",
              ),
              onChanged: (value) {
                _convert();
              },
            ),
            const SizedBox(height: 16),
            Text(
              _convertedValue.toStringAsFixed(2),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const Spacer(),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String currentValue, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: currentValue,
      items: lengthConversionRates.keys
          .map(
            (unit) => DropdownMenuItem(
              value: unit,
              child: Text(unit),
            ),
          )
          .toList(),
      onChanged: onChanged,
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
        _buildKeypadRow(["0", ",", "AC"]),
      ],
    );
  }

  Widget _buildKeypadRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return ElevatedButton(
          onPressed: () {
            if (button == "AC") {
              _clearInput();
            } else {
              setState(() {
                _inputController.text += button;
                _convert();
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: button == "AC" ? Colors.orange : Colors.white,
            foregroundColor: button == "AC" ? Colors.white : Colors.black,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            button,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}
