import 'package:flutter/material.dart';

class EkonomiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ekonomi"),
        backgroundColor: Colors.green, // Menggunakan warna hijau untuk Ekonomi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding untuk seluruh body
        child: ListView(
          children: [
            // Materi pertama
            Container(
              color: Colors.grey[200], // Memberikan warna latar belakang sedikit berbeda
              child: ExpansionTile(
                title: Text("Akuntansi sebagai sistem informasi • Part 1"),
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
                        Text("- Persamaan Akuntansi: Aset = Kewajiban + Ekuitas"),
                        Text("- Rumus untuk menghitung laba bersih: Laba Bersih = Pendapatan - Beban"),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("1. Jika aset perusahaan sebesar Rp 1.000.000 dan kewajiban sebesar Rp 600.000, berapakah ekuitas perusahaan tersebut?"),
                        Text("2. Hitung laba bersih jika perusahaan memiliki pendapatan Rp 500.000 dan beban Rp 300.000!"),
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
                title: Text("Pencatatan Transaksi Keuangan dalam Akuntansi • Part 2"),
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
                        Text("- Jurnal Umum: Mencatat setiap transaksi keuangan yang terjadi dalam suatu perusahaan."),
                        Text("- Buku Besar: Digunakan untuk mengelompokkan transaksi berdasarkan akun-akun yang relevan."),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("1. Catat transaksi pembelian barang secara kredit sebesar Rp 50.000!"),
                        Text("2. Tentukan saldo akhir akun kas jika dimulai dengan saldo Rp 100.000 dan ada pengeluaran Rp 40.000!"),
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
                title: Text("Akuntansi untuk Bisnis Kecil dan Menengah • Part 3"),
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
                        Text("- Laporan Laba Rugi: Laporan yang menunjukkan pendapatan dan biaya selama periode akuntansi."),
                        Text("- Neraca: Menampilkan posisi keuangan perusahaan pada suatu waktu tertentu."),
                        SizedBox(height: 16),
                        Text(
                          "Contoh Soal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("1. Hitung laba rugi perusahaan jika pendapatan Rp 1.000.000 dan biaya Rp 700.000!"),
                        Text("2. Tentukan saldo akhir neraca jika aset perusahaan Rp 1.200.000 dan kewajiban Rp 800.000!"),
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
