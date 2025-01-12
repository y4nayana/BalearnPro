import 'package:flutter/material.dart';

class BahasaInggrisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bahasa Inggris"),
        backgroundColor: Colors.green, // Menggunakan warna hijau untuk Bahasa Inggris
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding untuk seluruh body
        child: ListView(
          children: [
            // Materi pertama
            Container(
              color: Colors.grey[200], // Memberikan warna latar belakang sedikit berbeda
              child: ExpansionTile(
                title: Text("Materi Bahasa Inggris Kelas XII Bab 9"),
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
                        Text("- Menulis kalimat dalam present perfect tense."),
                        Text("- Penggunaan kata penghubung dalam percakapan."),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("1. Lengkapilah kalimat berikut dengan kata kerja yang tepat: I __________ (eat) lunch just now."),
                        Text("2. Buatlah dialog dengan menggunakan kata penghubung 'however'!"),
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
                title: Text("Materi Bahasa Inggris Kelas XII Bab 8"),
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
                        Text("- Membuat kalimat tanya menggunakan 'what', 'where', 'how', dan 'why'."),
                        Text("- Menulis percakapan dalam situasi formal dan informal."),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("1. Tanyakan waktu dengan menggunakan kata tanya yang tepat!"),
                        Text("2. Tulis percakapan antara dua orang yang berbicara di kantor!"),
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
                title: Text("Materi Bahasa Inggris Kelas XII Bab 9 (Lanjutan)"),
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
                        Text("- Menggunakan bentuk kalimat pasif dan aktif."),
                        Text("- Menggunakan kalimat dalam present continuous tense."),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("1. Ubah kalimat aktif berikut menjadi pasif: 'She writes the letter every day'."),
                        Text("2. Buatlah kalimat dalam present continuous tense yang menunjukkan suatu kegiatan yang sedang berlangsung!"),
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
