import 'package:flutter/material.dart';

class CurrencyConversionScreen extends StatefulWidget {
  const CurrencyConversionScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyConversionScreen> createState() =>
      _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedCurrencyFrom = "IDR";
  String _selectedCurrencyTo = "USD";
  double _convertedValue = 0.0;

  final Map<String, double> conversionRates = {
    "IDR to USD": 0.00007,
    "USD to IDR": 14300.0,
    "IDR to EUR": 0.00006,
    "EUR to IDR": 15900.0,
    "USD to EUR": 0.9,
    "EUR to USD": 1.1,
    "IDR to IDR": 1,
    "USD to USD": 1,
    "EUR to EUR": 1,
    "JPY to IDR": 132.0,
    "IDR to JPY": 0.0076,
    "JPY to USD": 0.007,
    "JPY to EUR": 0.0065,
    "EUR to JPY": 153.0,
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;
      String conversionKey = "$_selectedCurrencyFrom to $_selectedCurrencyTo";
      _convertedValue = input * (conversionRates[conversionKey] ?? 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> currencies = ["IDR", "USD", "EUR", "JPY"]; // Tambahkan opsi mata uang
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Mata Uang",
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
              // Dropdown untuk mata uang asal
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _selectedCurrencyFrom,
                    items: currencies
                        .map((currency) => DropdownMenuItem(
                              value: currency,
                              child: Text(
                                currency,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCurrencyFrom = value!;
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
              // Dropdown untuk mata uang tujuan
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _selectedCurrencyTo,
                    items: currencies
                        .map((currency) => DropdownMenuItem(
                              value: currency,
                              child: Text(
                                currency,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCurrencyTo = value!;
                      });
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
