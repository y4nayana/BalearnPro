import 'package:flutter/material.dart';

class NumberSystemConversionScreen extends StatefulWidget {
  const NumberSystemConversionScreen({super.key});

  @override
  _NumberSystemConversionScreenState createState() =>
      _NumberSystemConversionScreenState();
}

class _NumberSystemConversionScreenState
    extends State<NumberSystemConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _convertedValue = "0";
  String _selectedUnitFrom = "DEC";
  String _selectedUnitTo = "BIN";

  void _convert() {
    setState(() {
      try {
        int input = int.tryParse(_inputController.text) ?? 0;
        switch ("$_selectedUnitFrom to $_selectedUnitTo") {
          case "DEC to BIN":
            _convertedValue = input.toRadixString(2);
            break;
          case "DEC to HEX":
            _convertedValue = input.toRadixString(16).toUpperCase();
            break;
          case "DEC to OCT":
            _convertedValue = input.toRadixString(8);
            break;
          case "BIN to DEC":
            _convertedValue =
                int.parse(_inputController.text, radix: 2).toString();
            break;
          case "HEX to DEC":
            _convertedValue =
                int.parse(_inputController.text, radix: 16).toString();
            break;
          case "OCT to DEC":
            _convertedValue =
                int.parse(_inputController.text, radix: 8).toString();
            break;
          default:
            _convertedValue = "0";
        }
      } catch (e) {
        _convertedValue = "Error";
      }
    });
  }

  void _clearInput() {
    setState(() {
      _inputController.clear();
      _convertedValue = "0"; // Reset hasil konversi
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> units = ["DEC", "BIN", "HEX", "OCT"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Sistem Angka",
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
                  _convertedValue,
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
            itemCount: 20, // Total 20 tombol
            itemBuilder: (context, index) {
              final keys = [
                "C",
                "⌫",
                "F",
                "E",
                "7",
                "8",
                "9",
                "D",
                "4",
                "5",
                "6",
                "C",
                "1",
                "2",
                "3",
                "B",
                "00",
                "0", // Angka 0 ditambahkan di sini
                ".",
                "A",
              ];
              final key = keys[index];
              final isHexKey =
                  ["A", "B", "C", "D", "E", "F"].contains(key); // HEX keys
              final isDisabled =
                  isHexKey && (_selectedUnitFrom != "HEX" && _selectedUnitTo != "HEX");

              return ElevatedButton(
                onPressed: isDisabled
                    ? null
                    : () {
                        if (key == "C") {
                          _clearInput(); // Memanggil fungsi _clearInput
                        } else if (key == "⌫") {
                          setState(() {
                            if (_inputController.text.isNotEmpty) {
                              _inputController.text = _inputController.text
                                  .substring(0, _inputController.text.length - 1);
                            }
                          });
                        } else {
                          setState(() {
                            _inputController.text += key;
                          });
                          _convert();
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDisabled ? Colors.grey[300] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  key,
                  style: TextStyle(
                    color: isDisabled ? Colors.grey : Colors.black,
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
