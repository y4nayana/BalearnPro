import 'package:flutter/material.dart';

class BiologiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biologi"),
        backgroundColor: Colors.green, // Menggunakan warna hijau untuk Biologi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding untuk seluruh body
        child: ListView(
          children: [
            // Materi pertama
            Container(
              color: Colors.grey[200], // Memberikan warna latar belakang sedikit berbeda
              child: ExpansionTile(
                title: Text("Hukum Mendel: Biologi Kelas 12 SMA • Part 1"),
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
                        Text("- Hukum Segregasi: Setiap individu membawa dua alel untuk setiap karakteristik dan hanya satu alel yang diturunkan kepada keturunannya."),
                        Text("- Hukum Asortasi Bebas: Alel untuk satu sifat akan diwariskan secara independen dari alel untuk sifat lainnya."),
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
                            "1. Jika seorang individu heterozigot (Aa) disilangkan dengan individu homozigot resesif (aa), berapakah rasio fenotipe anak-anaknya?"),
                        Text(
                            "2. Sebuah tanaman bunga merah (RR) disilangkan dengan tanaman bunga putih (rr). Apa warna bunga keturunannya?"),
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
                title: Text("Hukum Mendel: Biologi Kelas 12 SMA • Part 2"),
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
                        Text("- Hukum Interaksi Gen: Interaksi antara dua gen atau lebih yang mempengaruhi satu sifat tertentu."),
                        Text("- Hukum Epistasis: Suatu gen dapat menghambat atau mempengaruhi ekspresi gen lainnya."),
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
                            "1. Apa yang terjadi jika gen A dominan menghambat gen B dalam suatu organisme?"),
                        Text(
                            "2. Tentukan rasio fenotipe pada persilangan yang melibatkan gen epistasis!"),
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
                title: Text("Hukum Mendel: Biologi Kelas 12 SMA • Part 3"),
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
                        Text("- Hukum Komplemen: Dua gen yang mempengaruhi satu sifat dapat bekerja secara sinergis."),
                        Text("- Hukum Polimorfisme: Keberadaan lebih dari dua alel untuk satu sifat pada suatu populasi."),
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
                            "1. Jelaskan bagaimana dua gen dapat bekerja sama untuk menghasilkan sifat yang berbeda!"),
                        Text(
                            "2. Bagaimana kehadiran lebih dari dua alel dapat mempengaruhi rasio fenotipe?"),
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
