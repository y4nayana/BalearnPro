import 'package:flutter/material.dart';

class VolumeConversionScreen extends StatefulWidget {
  const VolumeConversionScreen({Key? key}) : super(key: key);

  @override
  State<VolumeConversionScreen> createState() => _VolumeConversionScreenState();
}

class _VolumeConversionScreenState extends State<VolumeConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _inputValue = '';
  double _convertedValue = 0.0;
  String _selectedUnitFrom = "m³";
  String _selectedUnitTo = "cm³";

  final Map<String, double> volumeConversionFactors = {
    "m³->cm³": 1000000.0, // Meter kubik ke Sentimeter kubik
    "cm³->m³": 1 / 1000000.0, // Sentimeter kubik ke Meter kubik
    "m³->L": 1000.0, // Meter kubik ke Liter
    "L->m³": 1 / 1000.0, // Liter ke Meter kubik
    "L->mL": 1000.0, // Liter ke Milliliter
    "mL->L": 1 / 1000.0, // Milliliter ke Liter
    "m³->m³": 1.0, // Meter kubik ke Meter kubik
    "cm³->cm³": 1.0, // Sentimeter kubik ke Sentimeter kubik
    "L->L": 1.0, // Liter ke Liter
    "mL->mL": 1.0, // Milliliter ke Milliliter
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputValue) ?? 0.0;
      String key = "$_selectedUnitFrom->$_selectedUnitTo";

      _convertedValue = input * (volumeConversionFactors[key] ?? 1.0);
    });
  }

  void _clearInput() {
    setState(() {
      _inputValue = '';
      _convertedValue = 0.0;
    });
  }

  void _updateInput(String value) {
    setState(() {
      if (value == "." && _inputValue.contains(".")) return; // Mencegah koma ganda
      _inputValue += value;
    });
    _convert();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> units = ["m³", "cm³", "L", "mL"]; // Tambahan opsi unit
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Volume",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedUnitFrom,
                    dropdownColor: Colors.white,
                    items: units
                        .map(
                          (unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnitFrom = value!;
                      });
                      _convert();
                    },
                  ),
                ),
                const Icon(Icons.swap_horiz, color: Colors.black),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedUnitTo,
                    dropdownColor: Colors.white,
                    items: units
                        .map(
                          (unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnitTo = value!;
                      });
                      _convert();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _inputValue.isEmpty ? "0" : _inputValue,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _convertedValue.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      itemCount: 20, // Total tombol: 0-9, AC, dan lainnya
      itemBuilder: (context, index) {
        final keys = [
          "C", "⌫", "%", "÷",
          "7", "8", "9", "×",
          "4", "5", "6", "−",
          "1", "2", "3", "+",
          "00", "0", ".", "=",
        ];
        final key = keys[index];

        return ElevatedButton(
          onPressed: () {
            if (key == "C") {
              _clearInput();
            } else if (key == "⌫") {
              setState(() {
                if (_inputValue.isNotEmpty) {
                  _inputValue = _inputValue.substring(0, _inputValue.length - 1);
                }
              });
              _convert();
            } else if (key == "=") {
              _convert();
            } else {
              _updateInput(key);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            key,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: (key == "C" || key == "⌫" || key == "%" || 
                            key == "=" || key == "÷" || key == "+" ||
                            key == "×" || key == "−")
                  ? Colors.blue
                  : Colors.black,
            ),
          ),
        );
      },
    );
  }
}
