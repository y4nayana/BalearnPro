import 'package:flutter/material.dart';

class CurrencyConversionScreen extends StatefulWidget {
  const CurrencyConversionScreen({super.key});

  @override
  _CurrencyConversionScreenState createState() =>
      _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  double _convertedValue1 = 0.0;
  double _convertedValue2 = 0.0;

  String _selectedCurrencyFrom = "IDR";
  String _selectedCurrencyTo = "USD";
  String _selectedCurrencyTo2 = "EUR";

  final Map<String, double> _conversionRates = {
    "IDR to USD": 0.00007,
    "IDR to EUR": 0.00006,
    "USD to IDR": 14300.0,
    "USD to EUR": 0.9,
    "EUR to IDR": 15900.0,
    "EUR to USD": 1.1,
    "IDR to IDR": 1,
    "USD to USD": 1,
    "EUR to EUR": 1,
    "JPY to IDR": 132.0,
    "JPY to USD": 0.007,
    "IDR to JPY": 0.0076,
    "JPY to EUR": 0.0065,
    // Tambahkan mata uang lainnya jika diperlukan
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;

      String conversionKey1 = "$_selectedCurrencyFrom to $_selectedCurrencyTo";
      String conversionKey2 = "$_selectedCurrencyFrom to $_selectedCurrencyTo2";

      _convertedValue1 = input * (_conversionRates[conversionKey1] ?? 1.0);
      _convertedValue2 = input * (_conversionRates[conversionKey2] ?? 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mata Uang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedCurrencyFrom,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: "IDR", child: Text("IDR")),
                        DropdownMenuItem(value: "USD", child: Text("USD")),
                        DropdownMenuItem(value: "EUR", child: Text("EUR")),
                        DropdownMenuItem(value: "JPY", child: Text("JPY")),
                        DropdownMenuItem(value: "GBP", child: Text("GBP")),
                        // Tambahkan lebih banyak mata uang jika diperlukan
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrencyFrom = value!;
                        });
                      },
                    ),
                  ),
                  const Icon(Icons.arrow_forward),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedCurrencyTo,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: "IDR", child: Text("IDR")),
                        DropdownMenuItem(value: "USD", child: Text("USD")),
                        DropdownMenuItem(value: "EUR", child: Text("EUR")),
                        DropdownMenuItem(value: "JPY", child: Text("JPY")),
                        DropdownMenuItem(value: "GBP", child: Text("GBP")),
                        // Tambahkan lebih banyak mata uang jika diperlukan
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrencyTo = value!;
                        });
                      },
                    ),
                  ),
                  const Icon(Icons.arrow_forward),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedCurrencyTo2,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: "IDR", child: Text("IDR")),
                        DropdownMenuItem(value: "USD", child: Text("USD")),
                        DropdownMenuItem(value: "EUR", child: Text("EUR")),
                        DropdownMenuItem(value: "JPY", child: Text("JPY")),
                        DropdownMenuItem(value: "GBP", child: Text("GBP")),
                        // Tambahkan lebih banyak mata uang jika diperlukan
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrencyTo2 = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _inputController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Masukkan nilai",
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _convert,
                child: const Text("Konversi"),
              ),
              const SizedBox(height: 16),
              Text(
                "$_selectedCurrencyFrom: ${_inputController.text}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "$_selectedCurrencyTo: $_convertedValue1",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "$_selectedCurrencyTo2: $_convertedValue2",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
