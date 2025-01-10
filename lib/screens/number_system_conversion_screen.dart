import 'package:flutter/material.dart';

class NumberSystemConversionScreen extends StatefulWidget {
  const NumberSystemConversionScreen({super.key});

  @override
  _NumberSystemConversionScreenState createState() => _NumberSystemConversionScreenState();
}

class _NumberSystemConversionScreenState extends State<NumberSystemConversionScreen> {
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
            _convertedValue = int.parse(_inputController.text, radix: 2).toString();
            break;
          case "HEX to DEC":
            _convertedValue = int.parse(_inputController.text, radix: 16).toString();
            break;
          case "OCT to DEC":
            _convertedValue = int.parse(_inputController.text, radix: 8).toString();
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
      _convertedValue = "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistem Angka"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedUnitFrom,
                  items: const [
                    DropdownMenuItem(value: "DEC", child: Text("DEC")),
                    DropdownMenuItem(value: "BIN", child: Text("BIN")),
                    DropdownMenuItem(value: "HEX", child: Text("HEX")),
                    DropdownMenuItem(value: "OCT", child: Text("OCT")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitFrom = value!;
                      _convert();
                    });
                  },
                ),
                const Icon(Icons.swap_horiz),
                DropdownButton<String>(
                  value: _selectedUnitTo,
                  items: const [
                    DropdownMenuItem(value: "DEC", child: Text("DEC")),
                    DropdownMenuItem(value: "BIN", child: Text("BIN")),
                    DropdownMenuItem(value: "HEX", child: Text("HEX")),
                    DropdownMenuItem(value: "OCT", child: Text("OCT")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitTo = value!;
                      _convert();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Masukkan nilai",
                    ),
                    onChanged: (value) {
                      _convert();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  _convertedValue,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  ...List.generate(10, (index) {
                    return _buildKeyButton(index.toString());
                  }),
                  _buildKeyButton("A", isHexKey: true),
                  _buildKeyButton("B", isHexKey: true),
                  _buildKeyButton("C", isHexKey: true),
                  _buildKeyButton("D", isHexKey: true),
                  _buildKeyButton("E", isHexKey: true),
                  _buildKeyButton("F", isHexKey: true),
                  _buildActionKey("AC", _clearInput, isAction: true),
                  _buildActionKey("⌫", () {
                    setState(() {
                      if (_inputController.text.isNotEmpty) {
                        _inputController.text = _inputController.text.substring(0, _inputController.text.length - 1);
                        _convert();
                      }
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyButton(String label, {bool isHexKey = false}) {
    final bool isDisabled = isHexKey &&
        (_selectedUnitFrom != "HEX" || _selectedUnitTo != "HEX");

    return ElevatedButton(
      onPressed: isDisabled
          ? null
          : () {
              setState(() {
                _inputController.text += label;
                _convert();
              });
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? Colors.grey[300] : Colors.white,
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: isDisabled ? Colors.grey : Colors.black,
        ),
      ),
    );
  }

  Widget _buildActionKey(String label, VoidCallback onPressed, {bool isAction = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isAction ? Colors.orange : Colors.white,
        foregroundColor: isAction ? Colors.white : Colors.black,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
