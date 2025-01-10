import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'conversion_screen.dart';


class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({super.key});

  @override
  KalkulatorScreenState createState() => KalkulatorScreenState();
}

class KalkulatorScreenState extends State<KalkulatorScreen> {
  String _output = "0";
  String _expression = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "AC") {
        _output = "0";
        _expression = "";
      } else if (value == "=") {
        try {
          _output = _evaluateExpression(_expression);
        } catch (e) {
          _output = "Error";
        }
      } else {
        if (_expression.isEmpty && value == "0") return;
        _expression += value;
        _output = _expression;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toString();
    } catch (_) {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.calculate),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConversionScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              color: Colors.black12,
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                _buildButtonRow(["AC", "⌫", "%", "/"]),
                const SizedBox(height: 8),
                _buildButtonRow(["7", "8", "9", "*"]),
                const SizedBox(height: 8),
                _buildButtonRow(["4", "5", "6", "-"]),
                const SizedBox(height: 8),
                _buildButtonRow(["1", "2", "3", "+"]),
                const SizedBox(height: 8),
                _buildLastButtonRow(["0", ",", "="]),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: () => _buttonPressed(button),
              style: ElevatedButton.styleFrom(
                backgroundColor: button == "=" ? Colors.orange : Colors.white,
                foregroundColor: button == "=" ? Colors.white : Colors.black,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: Text(
                button,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLastButtonRow(List<String> buttons) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: () => _buttonPressed(buttons[0]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: Text(
                buttons[0],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: () => _buttonPressed(buttons[1]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: Text(
                buttons[1],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: () => _buttonPressed(buttons[2]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: Text(
                buttons[2],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}