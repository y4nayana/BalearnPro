import 'package:flutter/material.dart';

class CurrencyConversionScreen extends StatefulWidget {
  const CurrencyConversionScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyConversionScreen> createState() => _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  double _idrValue = 0.0;
  double _usdValue = 0.0;
  double _eurValue = 0.0;

  final Map<String, double> exchangeRates = {
    "IDR": 1.0,
    "USD": 0.000066, // Contoh nilai tukar (IDR ke USD)
    "EUR": 0.000057, // Contoh nilai tukar (IDR ke EUR)
  };

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0.0;
      _idrValue = input;
      _usdValue = input * exchangeRates["USD"]!;
      _eurValue = input * exchangeRates["EUR"]!;
    });
  }

  void _clearInput() {
    setState(() {
      _inputController.clear();
      _idrValue = 0.0;
      _usdValue = 0.0;
      _eurValue = 0.0;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCurrencyDropdown("IDR"),
                const Icon(Icons.arrow_forward),
                _buildCurrencyDropdown("USD"),
                const Icon(Icons.arrow_forward),
                _buildCurrencyDropdown("EUR"),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan nilai (IDR)",
              ),
              onChanged: (value) {
                _convert();
              },
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildResultRow("Rupiah Indonesia", _idrValue),
                const SizedBox(height: 8),
                _buildResultRow("Dolar Amerika Serikat", _usdValue),
                const SizedBox(height: 8),
                _buildResultRow("Euro", _eurValue),
              ],
            ),
            const Spacer(),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(String currency) {
    return DropdownButton<String>(
      value: currency,
      items: const [
        DropdownMenuItem(value: "IDR", child: Text("IDR")),
        DropdownMenuItem(value: "USD", child: Text("USD")),
        DropdownMenuItem(value: "EUR", child: Text("EUR")),
      ],
      onChanged: (value) {
        // Untuk saat ini dropdown hanya menampilkan nilai statis
      },
    );
  }

  Widget _buildResultRow(String label, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          value.toStringAsFixed(2),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
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
                _convert();
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
