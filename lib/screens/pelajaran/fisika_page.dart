import 'package:flutter/material.dart';

class FisikaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fisika"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding untuk seluruh body
        child: ListView(
          children: [
            // Materi pertama
            Container(
              color: Colors.grey[200], // Memberikan warna latar belakang sedikit berbeda
              child: ExpansionTile(
                title: Text("Listrik Dinamis • Part 1: Hukum Ohm, Hukum Coulomb, dan Resistor"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rumus-rumus:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("- Hukum Ohm: V = I × R"),
                        Text("- Hukum Coulomb: F = k × (q1 × q2) / r²"),
                        Text("- Resistor: R = ρ × (L / A)"),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            "1. Tentukan besar tegangan pada resistor 4 ohm yang mengalirkan arus 2 ampere!"),
                        Text(
                            "2. Hitung gaya yang bekerja antara dua muatan 2 × 10⁻⁶ C dan 3 × 10⁻⁶ C yang berjarak 0,5 m!"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Materi kedua
            Container(
              color: Colors.grey[200], // Memberikan warna latar belakang sedikit berbeda
              child: ExpansionTile(
                title: Text("Listrik Dinamis • Part 2: Hukum Kirchhoff, Rangkaian Paralel dan Seri"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rumus-rumus:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("- Hukum Kirchhoff: ΣI = 0, ΣV = 0"),
                        Text("- Rangkaian Seri: Rt = R1 + R2 + R3 + ..."),
                        Text("- Rangkaian Paralel: 1/Rt = 1/R1 + 1/R2 + 1/R3 + ..."),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            "1. Hitung total resistansi pada rangkaian seri yang terdiri dari 3 resistor masing-masing 4 ohm, 6 ohm, dan 8 ohm!"),
                        Text(
                            "2. Tentukan total resistansi pada rangkaian paralel yang terdiri dari 3 resistor masing-masing 10 ohm, 20 ohm, dan 30 ohm!"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Materi ketiga
            Container(
              color: Colors.grey[200], // Memberikan warna latar belakang sedikit berbeda
              child: ExpansionTile(
                title: Text("Listrik Dinamis • Part 3: Energi Listrik, Daya, dan Efisiensi"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rumus-rumus:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("- Energi Listrik: E = P × t"),
                        Text("- Daya: P = V × I"),
                        Text("- Efisiensi: η = (Energi Keluaran / Energi Masukan) × 100%"),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            "1. Sebuah alat listrik berdaya 100 W digunakan selama 5 jam. Hitung energi listrik yang digunakan!"),
                        Text(
                            "2. Sebuah mesin memiliki efisiensi 80%. Jika energi masukan 500 J, berapakah energi keluaran mesin tersebut?"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
