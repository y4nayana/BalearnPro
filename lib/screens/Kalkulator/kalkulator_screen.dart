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

  // PageController untuk mengatur PageView
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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
      // Ganti simbol operator dengan simbol yang dikenali oleh parser
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      expression = expression.replaceAll('−', '-');
      
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          color: isDarkMode ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(0);
                  setState(() {
                    _currentPage = 0;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.calculate_outlined,
                      color: _currentPage == 0
                          ? (isDarkMode ? Colors.white : Colors.black)
                          : Colors.grey,
                    ),
                    Text(
                      "Kalkulator",
                      style: TextStyle(
                        color: _currentPage == 0
                            ? (isDarkMode ? Colors.white : Colors.black)
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(1);
                  setState(() {
                    _currentPage = 1;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.swap_horiz,
                      color: _currentPage == 1
                          ? (isDarkMode ? Colors.white : Colors.black)
                          : Colors.grey,
                    ),
                    Text(
                      "Konversi",
                      style: TextStyle(
                        color: _currentPage == 1
                            ? (isDarkMode ? Colors.white : Colors.black)
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          // Halaman Kalkulator
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomRight,
                  color: isDarkMode ? Colors.black12 : Colors.black12,
                  child: Text(
                    _output,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0, // Tambahan padding vertikal untuk jarak
                  ),
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16, // Jarak horizontal antar tombol
                      mainAxisSpacing: 16, // Jarak vertikal antar tombol
                    ),
                    itemCount: 20, // Total 20 tombol
                    itemBuilder: (context, index) {
                      final keys = [
                        "AC",
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
                        onPressed: () => _buttonPressed(key),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode
                              ? (key == "=" ? Colors.blue[900] : Colors.grey[800])
                              : Colors.white,
                          foregroundColor: (key == "=" ||
                                  key == "+" ||
                                  key == "−" ||
                                  key == "×" ||
                                  key == "÷" ||
                                  key == "%" || // Warna tombol % khusus operator
                                  key == "AC" ||
                                  key == "⌫")
                              ? Colors.blue // Operator dan kontrol berwarna biru
                              : (isDarkMode ? Colors.white : Colors.black), // Angka
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          key,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          // Halaman Konverter
          const ConversionScreen(),
        ],
      ),
    );
  }
}
