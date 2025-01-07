// screens/calculator/conversion_screen.dart

import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedConversion = 'Suhu';
  String _result = '';

  void _convert() {
    final double input = double.tryParse(_inputController.text) ?? 0;
    double convertedValue;

    switch (_selectedConversion) {
      case 'Suhu':
        convertedValue = (input * 9 / 5) + 32; // Celsius to Fahrenheit
        setState(() {
          _result = '$input °C = $convertedValue °F';
        });
        break;
      case 'Mata Uang':
        convertedValue = input * 15000; // Example: USD to IDR
        setState(() {
          _result = '\$ $input = Rp $convertedValue';
        });
        break;
      case 'Berat':
        convertedValue = input * 2.20462; // Kilograms to Pounds
        setState(() {
          _result = '$input kg = $convertedValue lbs';
        });
        break;
      default:
        setState(() {
          _result = 'Conversion not available';
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversion Tool'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              decoration: InputDecoration(labelText: 'Enter value'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedConversion,
              onChanged: (value) {
                setState(() {
                  _selectedConversion = value!;
                });
              },
              items: ['Suhu', 'Mata Uang', 'Berat']
                  .map((conversion) => DropdownMenuItem(
                        value: conversion,
                        child: Text(conversion),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
