import 'package:flutter/material.dart';

class BiologiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biologi"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          "Ini adalah halaman Biologi",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
