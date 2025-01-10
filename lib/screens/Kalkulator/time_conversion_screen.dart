import 'package:flutter/material.dart';

class TimeConversionScreen extends StatefulWidget {
  const TimeConversionScreen({super.key});

  @override
  State<TimeConversionScreen> createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  double _convertedValue = 0.0;
  String _selectedUnitFrom = "mnt";
  String _selectedUnitTo = "d";

  final Map<String, double> timeConversionFactors = {
    "mnt->d": 60.0, // Menit ke detik
    "d->mnt": 1 / 60.0, // Detik ke menit
    "mnt->mnt": 1.0, // Menit ke menit
    "d->d": 1.0, // Detik ke detik
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;
      String key = "$_selectedUnitFrom->$_selectedUnitTo";

      _convertedValue = input * (timeConversionFactors[key] ?? 1.0);
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
        title: const Text("Waktu"),
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
                    DropdownMenuItem(value: "mnt", child: Text("Menit")),
                    DropdownMenuItem(value: "d", child: Text("Detik")),
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
                    DropdownMenuItem(value: "mnt", child: Text("Menit")),
                    DropdownMenuItem(value: "d", child: Text("Detik")),
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
              "Hasil: ${_convertedValue.toStringAsFixed(2)} $_selectedUnitTo",
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
