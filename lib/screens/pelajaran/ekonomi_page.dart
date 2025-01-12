import 'package:flutter/material.dart';

class EkonomiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ekonomi"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          "Ini adalah halaman Ekonomi",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
