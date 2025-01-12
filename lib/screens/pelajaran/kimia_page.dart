import 'package:flutter/material.dart';

class KimiaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kimia"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          "Ini adalah halaman Kimia",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
