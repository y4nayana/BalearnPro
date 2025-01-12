import 'package:flutter/material.dart';

class MatematikaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matematika"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding sekitar
        child: ListView(
          children: [
            // Materi pertama
            Container(
              color: Colors.grey[200], // Memberikan warna latar belakang sedikit berbeda
              child: ExpansionTile(
                title: Text("Bangun Ruang (Dimensi Tiga)"),
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
                        Text("- Volume Kubus: V = s³"),
                        Text("- Volume Balok: V = p × l × t"),
                        Text("- Volume Prisma: V = Luas Alas × Tinggi"),
                        Text("- Volume Limas: V = 1/3 × Luas Alas × Tinggi"),
                        Text("- Volume Bola: V = 4/3 × π × r³"),
                        Text("- Volume Tabung: V = π × r² × t"),
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
                            "1. Sebuah kubus memiliki panjang sisi 5 cm. Berapakah volume kubus tersebut?"),
                        Text(
                            "2. Sebuah balok memiliki panjang 8 cm, lebar 4 cm, dan tinggi 3 cm. Hitung volumenya!"),
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
                title: Text("Persamaan Kuadrat"),
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
                        Text("- Bentuk umum: ax² + bx + c = 0"),
                        Text("- Rumus diskriminan (D): D = b² - 4ac"),
                        Text("- Rumus akar-akar: x = (-b ± √D) / 2a"),
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
                            "1. Tentukan akar-akar persamaan kuadrat x² - 5x + 6 = 0!"),
                        Text(
                            "2. Hitung diskriminan dari persamaan kuadrat 2x² + 3x - 2 = 0!"),
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
                title: Text("Aljabar Dasar"),
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
                        Text("- (a + b)² = a² + 2ab + b²"),
                        Text("- (a - b)² = a² - 2ab + b²"),
                        Text("- (a + b)(a - b) = a² - b²"),
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
                            "1. Sederhanakan (x + 2)(x - 2) menggunakan rumus aljabar!"),
                        Text(
                            "2. Hitung hasil (3 + 4)² dan verifikasi dengan cara panjang."),
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
