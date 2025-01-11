import 'package:flutter/material.dart';

class TimeConversionScreen extends StatefulWidget {
  const TimeConversionScreen({super.key});

  @override
  State<TimeConversionScreen> createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  double _convertedValue = 0.0;
  String _selectedUnitFrom = "s"; // Default dari detik
  String _selectedUnitTo = "mnt"; // Default ke menit

  final Map<String, double> timeConversionFactors = {
    "s->mnt": 1 / 60.0,       // Detik ke menit
    "mnt->s": 60.0,           // Menit ke detik
    "s->jam": 1 / 3600.0,     // Detik ke jam
    "jam->s": 3600.0,         // Jam ke detik
    "s->hari": 1 / 86400.0,   // Detik ke hari
    "hari->s": 86400.0,       // Hari ke detik
    "s->minggu": 1 / 604800.0, // Detik ke minggu
    "minggu->s": 604800.0,    // Minggu ke detik

    "mnt->jam": 1 / 60.0,     // Menit ke jam
    "jam->mnt": 60.0,         // Jam ke menit
    "mnt->hari": 1 / 1440.0,  // Menit ke hari
    "hari->mnt": 1440.0,      // Hari ke menit
    "mnt->minggu": 1 / 10080.0, // Menit ke minggu
    "minggu->mnt": 10080.0,   // Minggu ke menit

    "jam->hari": 1 / 24.0,    // Jam ke hari
    "hari->jam": 24.0,        // Hari ke jam
    "jam->minggu": 1 / 168.0, // Jam ke minggu
    "minggu->jam": 168.0,     // Minggu ke jam

    "hari->minggu": 1 / 7.0,  // Hari ke minggu
    "minggu->hari": 7.0,      // Minggu ke hari

    // Jika unit sama, tetap 1
    "s->s": 1.0,
    "mnt->mnt": 1.0,
    "jam->jam": 1.0,
    "hari->hari": 1.0,
    "minggu->minggu": 1.0,
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
    final List<String> units = ["s", "mnt", "jam", "hari", "minggu"]; // Tambahkan opsi unit
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Waktu",
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
