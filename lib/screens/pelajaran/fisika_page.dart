import 'package:flutter/material.dart';

class FisikaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fisika"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          "Ini adalah halaman Fisika",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
