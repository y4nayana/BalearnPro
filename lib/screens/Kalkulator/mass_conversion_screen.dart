import 'package:flutter/material.dart';

class MassConversionScreen extends StatefulWidget {
  const MassConversionScreen({super.key});

  @override
  _MassConversionScreenState createState() => _MassConversionScreenState();
}

class _MassConversionScreenState extends State<MassConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
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
      double input = double.tryParse(_inputController.text) ?? 0.0;
      String conversionKey = "$_selectedUnitFrom to $_selectedUnitTo";
      _convertedValue = input * (_conversionRates[conversionKey] ?? 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> units = [
      "Kilogram",
      "Gram",
      "Ton",
      "Milligram",
      "Pound"
    ]; // Tambahan opsi unit
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Massa",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dropdown untuk unit asal
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _selectedUnitFrom,
                    items: units
                        .map((unit) => DropdownMenuItem(
                              value: unit,
                              child: Text(
                                unit,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnitFrom = value!;
                      });
                    },
                  ),
                ),
              ),
              // Nilai input
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  _inputController.text.isEmpty
                      ? "0"
                      : _inputController.text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dropdown untuk unit tujuan
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _selectedUnitTo,
                    items: units
                        .map((unit) => DropdownMenuItem(
                              value: unit,
                              child: Text(
                                unit,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnitTo = value!;
                      });
                    },
                  ),
                ),
              ),
              // Hasil konversi
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  _convertedValue.toStringAsFixed(3),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Keyboard numerik
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16, // Tambahkan jarak horizontal antar tombol
              mainAxisSpacing: 16, // Tambahkan jarak vertikal antar tombol
            ),
            shrinkWrap: true,
            itemCount: 20, // Total 20 tombol termasuk angka 0 dan 00
            itemBuilder: (context, index) {
              final keys = [
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
                "−",
                "1",
                "2",
                "3",
                "+",
                "00",
                "0",
                ".",
                "=",
              ];
              final key = keys[index];

              return ElevatedButton(
                onPressed: () {
                  if (key == "C") {
                    _inputController.clear();
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
                  }
                  _convert();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background putih
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
                            key == "−")
                        ? Colors.blue // Operator dan kontrol berwarna biru
                        : Colors.black, // Angka hitam
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
