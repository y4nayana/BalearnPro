import 'package:flutter/material.dart';

class KimiaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kimia"),
        backgroundColor: Colors.blue, // Menggunakan warna biru untuk Kimia
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding untuk seluruh body
        child: ListView(
          children: [
            // Materi pertama
            Container(
              color: Colors.grey[200], // Memberikan warna latar belakang sedikit berbeda
              child: ExpansionTile(
                title: Text("Kimia Unsur • Part 1: Gas Mulia"),
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
                        Text("- Gas Mulia memiliki konfigurasi elektron yang stabil."),
                        Text("- Hukum Dalton: P_total = P_1 + P_2 + P_3 ..."),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("1. Apa yang dimaksud dengan gas mulia dan bagaimana sifatnya?"),
                        Text("2. Jika tekanan total sistem gas adalah 300 kPa, dan tekanan gas A adalah 120 kPa, hitung tekanan gas lainnya jika terdapat dua gas lainnya."),
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
                title: Text("Kimia Unsur • Part 2: Halogen"),
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
                        Text("- Halogen terdiri dari unsur-unsur kelompok 17 dalam tabel periodik."),
                        Text("- Ikatan kovalen pada halogen membentuk senyawa ion."),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("1. Jelaskan sifat-sifat halogen dalam kimia dan berikan contoh senyawa yang dibentuknya!"),
                        Text("2. Jika jumlah atom halogen dalam senyawa X adalah 2, hitung jumlah elektron yang terlibat dalam ikatan."),
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
                title: Text("Kimia Unsur • Part 3: Logam Alkali"),
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
                        Text("- Logam alkali memiliki satu elektron di kulit terluar yang sangat mudah dilepaskan."),
                        Text("- Rumus Reaksi: 2Na + Cl₂ → 2NaCl"),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("1. Mengapa logam alkali sangat reaktif? Jelaskan dengan sifat kimianya!"),
                        Text("2. Tulis reaksi kimia antara natrium dan klorin dalam pembentukan senyawa natrium klorida!"),
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
