import 'package:flutter/material.dart';

class SpeedConversionScreen extends StatefulWidget {
  const SpeedConversionScreen({super.key});

  @override
  _SpeedConversionScreenState createState() => _SpeedConversionScreenState();
}

class _SpeedConversionScreenState extends State<SpeedConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  double _convertedValue = 0.0;
  String _selectedUnitFrom = "m/s";
  String _selectedUnitTo = "km/h";

  final Map<String, double> speedConversionRates = {
    "m/s": 1.0,
    "km/h": 3.6,
    "km/s": 0.001,
    "mph": 2.23694,
    "ft/s": 3.28084,
    "cm/s": 100.0,
    "inch/s": 39.3701,
    // Same unit (conversion rate = 1)
    "m/s to m/s": 1.0,
    "km/h to km/h": 1.0,
    "km/s to km/s": 1.0,
    "mph to mph": 1.0,
    "ft/s to ft/s": 1.0,
    "cm/s to cm/s": 1.0,
    "inch/s to inch/s": 1.0,
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;
      double fromRate = speedConversionRates[_selectedUnitFrom]!;
      double toRate = speedConversionRates[_selectedUnitTo]!;
      _convertedValue = input * (toRate / fromRate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> units = [
      "m/s",
      "km/h",
      "km/s",
      "mph",
      "ft/s",
      "cm/s",
      "inch/s",
    ]; // Tambahkan opsi unit kecepatan
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Kecepatan",
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
              crossAxisSpacing: 16, // Jarak horizontal antar tombol
              mainAxisSpacing: 16, // Jarak vertikal antar tombol
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
