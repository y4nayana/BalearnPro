import 'package:flutter/material.dart';
import 'bmi_conversion_screen.dart';
import 'data_conversion_screen.dart';
import 'length_conversion_screen.dart';
import 'mass_conversion_screen.dart';
import 'number_system_conversion_screen.dart';
import 'speed_conversion_screen.dart';
import 'temperature_conversion_screen.dart';
import 'time_conversion_screen.dart';
import 'volume_conversion_screen.dart';
import 'currency_conversion_screen.dart';

class ConversionScreen extends StatelessWidget {
  const ConversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar opsi konversi tanpa "Area"
    final List<Map<String, dynamic>> conversionOptions = [
      {
        "label": "BMI",
        "icon": Icons.accessibility_new,
        "page": const BMIConversionScreen()
      },
      {
        "label": "Data",
        "icon": Icons.data_usage,
        "page": const DataConversionScreen()
      },
      {
        "label": "Panjang",
        "icon": Icons.straighten,
        "page": const LengthConversionScreen()
      },
      {
        "label": "Massa",
        "icon": Icons.fitness_center,
        "page": const MassConversionScreen()
      },
      {
        "label": "Sistem Angka",
        "icon": Icons.repeat,
        "page": const NumberSystemConversionScreen()
      },
      {
        "label": "Kecepatan",
        "icon": Icons.speed,
        "page": const SpeedConversionScreen()
      },
      {
        "label": "Suhu",
        "icon": Icons.thermostat,
        "page": const TemperatureConversionScreen()
      },
      {
        "label": "Waktu",
        "icon": Icons.access_time,
        "page": const TimeConversionScreen()
      },
      {
        "label": "Volume",
        "icon": Icons.category,
        "page": const VolumeConversionScreen()
      },
      {
        "label": "Mata Uang",
        "icon": Icons.attach_money,
        "page": const CurrencyConversionScreen()
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Konversi"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 kolom
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: conversionOptions.length,
        itemBuilder: (context, index) {
          final option = conversionOptions[index];
          return GestureDetector(
            onTap: () {
              // Log debugging saat item di-tap
              print("Navigating to: ${option['label']}");

              try {
                // Navigasi ke halaman yang dipilih
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => option["page"]),
                );

                // Log sukses jika navigasi berhasil
                print("Navigation to ${option['label']} succeeded.");
              } catch (e) {
                // Log error jika navigasi gagal
                print("Error navigating to ${option['label']}: $e");
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  option["icon"],
                  size: 40,
                  color: Colors.blue, // Warna ikon diubah menjadi biru
                ),
                const SizedBox(height: 8),
                Text(
                  option["label"],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
