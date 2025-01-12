import 'package:flutter/material.dart';
import 'package:balearnpro2/screens/video/video_screen.dart';

class EkonomiPlaylistScreen extends StatelessWidget {
  final Map<String, dynamic> playlist;

  EkonomiPlaylistScreen({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist["Fisika"]), // Menampilkan nama playlist
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Tombol back
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Tambahkan padding untuk seluruh konten
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background abu terang untuk semua konten
            borderRadius: BorderRadius.circular(16), // Rounded pada tepi background
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Thumbnail Video Pertama
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        playlist["videos"][0]["thumbnail"], // Thumbnail video pertama
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Tombol Putar Semua
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Arahkan ke VideoScreen untuk memutar video pertama
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              videoId: playlist["videos"][0]["id"], // Video pertama
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.black, // Warna icon hitam
                      ),
                      label: Text(
                        "Putar Semua",
                        style: TextStyle(color: Colors.black), // Teks warna hitam
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Daftar Video
              Expanded(
                child: ListView.builder(
                  itemCount: playlist["videos"].length,
                  itemBuilder: (context, index) {
                    final video = playlist["videos"][index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Background putih untuk setiap video
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Bayangan ringan
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2), // Posisi bayangan
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              video["thumbnail"], // Thumbnail video
                              fit: BoxFit.cover,
                              width: 100,
                              height: 70,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image); // Fallback jika gagal memuat
                              },
                            ),
                          ),
                          title: Text(
                            video["title"], // Judul video
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(video["duration"]), // Durasi video (jika ada)
                          onTap: () {
                            // Arahkan ke VideoScreen untuk memutar video yang dipilih
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoScreen(
                                  videoId: video["id"], // Kirim videoId ke VideoScreen
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
