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
        backgroundColor: Colors.white,
        title: const Text(
          "Panjang",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildConversionRow(
              _selectedFromUnit,
              (value) {
                setState(() {
                  _selectedFromUnit = value!;
                  _convert();
                });
              },
              _inputController,
            ),
            const SizedBox(height: 16),
            _buildConversionRow(
              _selectedToUnit,
              (value) {
                setState(() {
                  _selectedToUnit = value!;
                  _convert();
                });
              },
              null, // Tidak perlu input untuk hasil
              isOutput: true,
              outputValue: _convertedValue.toStringAsFixed(2),
            ),
            const Spacer(),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionRow(
    String currentUnit,
    ValueChanged<String?> onChanged,
    TextEditingController? controller, {
    bool isOutput = false,
    String? outputValue,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<String>(
          value: currentUnit,
          dropdownColor: Colors.white,
          items: lengthConversionRates.keys
              .map(
                (unit) => DropdownMenuItem(
                  value: unit,
                  child: Text(
                    unit,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
        isOutput
            ? Text(
                outputValue ?? "0.0",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            : Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "0",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    _convert();
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildKeypad() {
    final List<String> keys = [
      "C",
      "⌫",
      "%",
      "÷",
      "7",
      "8",
      "9",
      "×",
      "4",
      "5",
      "6",
      "-",
      "1",
      "2",
      "3",
      "+",
      "00",
      "0",
      ".",
      "=",
    ];
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      shrinkWrap: true,
      itemCount: keys.length,
      itemBuilder: (context, index) {
        final key = keys[index];
        return ElevatedButton(
          onPressed: () {
            if (key == "C") {
              _clearInput();
            } else if (key == "⌫") {
              final text = _inputController.text;
              if (text.isNotEmpty) {
                _inputController.text =
                    text.substring(0, text.length - 1);
              }
            } else if (key == "=") {
              _convert();
            } else {
              _inputController.text += key;
              _convert();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
          ),
          child: Text(
            key,
            style: TextStyle(
              color: (key == "C" ||
                      key == "⌫" ||
                      key == "%" ||
                      key == "=" ||
                      key == "÷" ||
                      key == "+" ||
                      key == "×" ||
                      key == "-")
                  ? Colors.blue // Operator dan kontrol berwarna biru
                  : Colors.black, // Angka hitam
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
