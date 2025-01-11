import 'package:flutter/material.dart';

class TemperatureConversionScreen extends StatefulWidget {
  const TemperatureConversionScreen({super.key});

  @override
  _TemperatureConversionScreenState createState() =>
      _TemperatureConversionScreenState();
}

class _TemperatureConversionScreenState
    extends State<TemperatureConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedUnitFrom = "°C";
  String _selectedUnitTo = "°F";
  double _convertedValue = 0.0;

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;

      if (_selectedUnitFrom == "°C" && _selectedUnitTo == "°F") {
        _convertedValue = (input * 9 / 5) + 32; // Celsius ke Fahrenheit
      } else if (_selectedUnitFrom == "°F" && _selectedUnitTo == "°C") {
        _convertedValue = (input - 32) * 5 / 9; // Fahrenheit ke Celsius
      } else if (_selectedUnitFrom == "°C" && _selectedUnitTo == "K") {
        _convertedValue = input + 273.15; // Celsius ke Kelvin
      } else if (_selectedUnitFrom == "K" && _selectedUnitTo == "°C") {
        _convertedValue = input - 273.15; // Kelvin ke Celsius
      } else if (_selectedUnitFrom == "°F" && _selectedUnitTo == "K") {
        _convertedValue = (input - 32) * 5 / 9 + 273.15; // Fahrenheit ke Kelvin
      } else if (_selectedUnitFrom == "K" && _selectedUnitTo == "°F") {
        _convertedValue = (input - 273.15) * 9 / 5 + 32; // Kelvin ke Fahrenheit
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
    final List<String> units = ["°C", "°F", "K"]; // Tambahan unit suhu
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Suhu",
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
                      _convert();
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
                      _convert();
                    },
                  ),
                ),
              ),
              // Hasil konversi
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  _convertedValue.toStringAsFixed(2),
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
                    color: (key == "C" || key == "⌫" || key == "%" || 
                            key == "=" || key == "÷" || key == "+" ||
                            key == "×" || key == "−")
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
