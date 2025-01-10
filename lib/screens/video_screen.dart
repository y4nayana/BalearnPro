import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool isDropdownOpen = false;

  // YouTube Video IDs
  final List<Map<String, String>> videos = [
    {
      "title": "Analisis Bangun Ruang (Dimensi Tiga) Matematika Wajib",
      "id": "xWA4AKKUQPU", // Ganti dengan YouTube Video ID kamu
    },
    {
      "title": "Analisis Trigonometri Matematika Wajib",
      "id": "XQ8UJAMJcUQ", // Ganti dengan YouTube Video ID kamu
    },
    {
      "title": "Analisis Geometri Matematika Minat",
      "id": "Dm8l1JeNva4", // Ganti dengan YouTube Video ID kamu
    },
    {
      "title": "Analisis Persamaan Kuadrat Matematika Minat",
      "id": "_nrLpuoZAgo", // Ganti dengan YouTube Video ID kamu
    },
    {
      "title": "Analisis Aljabar Dasar Matematika Minat",
      "id": "xr1ZGe4JwC0", // Ganti dengan YouTube Video ID kamu
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Playlist Matematika
            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpen = !isDropdownOpen;
                });
              },
              child: Container(
                color: Colors.grey[300],
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Matematika",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
            ),
            if (isDropdownOpen)
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return VideoThumbnail(
                      title: videos[index]["title"]!,
                      videoId: videos[index]["id"]!,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class VideoThumbnail extends StatelessWidget {
  final String title;
  final String videoId;

  const VideoThumbnail({required this.title, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: AspectRatio(
              aspectRatio: 16 / 9,
              child: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                  ),
                ),
                showVideoProgressIndicator: true,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Tutup"),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_fill,
              size: 50,
              color: Colors.red,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
