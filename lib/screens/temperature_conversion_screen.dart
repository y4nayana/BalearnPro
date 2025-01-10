import 'package:flutter/material.dart';

class TemperatureConversionScreen extends StatefulWidget {
  const TemperatureConversionScreen({super.key});

  @override
  State<TemperatureConversionScreen> createState() => _TemperatureConversionScreenState();
}

class _TemperatureConversionScreenState extends State<TemperatureConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  double _convertedValue = 0.0;
  String _selectedUnitFrom = "°C";
  String _selectedUnitTo = "°F";

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;

      if (_selectedUnitFrom == "°C" && _selectedUnitTo == "°F") {
        _convertedValue = (input * 9 / 5) + 32;
      } else if (_selectedUnitFrom == "°F" && _selectedUnitTo == "°C") {
        _convertedValue = (input - 32) * 5 / 9;
      } else {
        _convertedValue = input; // Jika unit sama
      }
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
        title: const Text("Suhu"),
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
                    DropdownMenuItem(value: "°C", child: Text("Celsius")),
                    DropdownMenuItem(value: "°F", child: Text("Fahrenheit")),
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
                    DropdownMenuItem(value: "°C", child: Text("Celsius")),
                    DropdownMenuItem(value: "°F", child: Text("Fahrenheit")),
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
