import 'package:flutter/material.dart';

class BahasaInggrisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bahasa Inggris"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          "Ini adalah halaman Bahasa Inggris",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
    