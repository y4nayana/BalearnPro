import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart'; // Untuk mengatur orientasi layar


class VideoScreen extends StatefulWidget {
  final String? videoId;

  VideoScreen({this.videoId});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.videoId ?? "xWA4AKKUQPU",
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );
    // Tambahkan listener untuk mendeteksi perubahan fullscreen
    _youtubeController.addListener(_onPlayerStateChange);
  }
  @override
  void _onPlayerStateChange() {
    if (_youtubeController.value.isFullScreen) {
      // Ubah orientasi ke landscape jika fullscreen diaktifkan
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      // Kembalikan orientasi ke portrait jika fullscreen dinonaktifkan
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  @override
  void dispose() {
    // Kembalikan orientasi ke portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Hapus listener untuk menghindari memory leak
    _youtubeController.removeListener(_onPlayerStateChange);
    _youtubeController.dispose();
  
    super.dispose();
  }


  void _rewind10Seconds() {
    final currentPosition = _youtubeController.value.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    _youtubeController.seekTo(newPosition);
  }

  void _togglePlayPause() {
    if (_youtubeController.value.isPlaying) {
      _youtubeController.pause();
    } else {
      _youtubeController.play();
    }
  }

  void _fastForward10Seconds() {
    final currentPosition = _youtubeController.value.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    _youtubeController.seekTo(newPosition);
  }

  void _playNewVideo(String videoId) {
    _youtubeController.load(videoId);
    _youtubeController.play();
  }

  void _showPlaylistDialog(BuildContext context, Map<String, dynamic> playlist) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                playlist["title"],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: playlist["videos"].length,
                itemBuilder: (context, index) {
                  final video = playlist["videos"][index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        video["thumbnail"],
                        fit: BoxFit.cover,
                        width: 70,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image);
                        },
                      ),
                    ),
                    title: Text(
                      video["title"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(video["duration"]),
                    onTap: () {
                      Navigator.pop(context); // Tutup pop-up
                      _playNewVideo(video["id"]);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.grey[300],
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.replay_10),
                  onPressed: _rewind10Seconds,
                ),
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    _youtubeController.value.isPlaying ? Icons.play_arrow : Icons.pause,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_youtubeController.value.isPlaying) {
                        _youtubeController.pause();
                      } else {
                        _youtubeController.play();
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.forward_10),
                  onPressed: _fastForward10Seconds,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final playlist = playlists[index];
                  return GestureDetector(
                    onTap: () {
                      _showPlaylistDialog(context, playlist);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              playlist["thumbnail"],
                              fit: BoxFit.cover,
                              width: 100,
                              height: 70,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image);
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  playlist["title"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Terdapat ${playlist["videos"].length} video",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// FORMAT DATA PLAYLIST DENGAN VIDEO
final List<Map<String, dynamic>> playlists = [
  {
    "title": "Matematika",
    "thumbnail": "https://img.youtube.com/vi/xWA4AKKUQPU/hqdefault.jpg",
    "videos": [
      {
        "title": "Analisis Bangun Ruang (Dimensi Tiga)",
        "id": "xWA4AKKUQPU",
        "thumbnail": "https://img.youtube.com/vi/xWA4AKKUQPU/hqdefault.jpg",
        "duration": "12:34",
      },
      {
        "title": "Analisis Persamaan Kuadrat",
        "id": "_nrLpuoZAgo",
        "thumbnail": "https://img.youtube.com/vi/_nrLpuoZAgo/hqdefault.jpg",
        "duration": "10:30"
      },
      {
        "title": "Analisis Aljabar Dasar",
        "id": "xr1ZGe4JwC0",
        "thumbnail": "https://img.youtube.com/vi/xr1ZGe4JwC0/hqdefault.jpg",
        "duration": "8:40"
      }
    ],
  },
  {
    "title": "Fisika",
    "thumbnail": "https://img.youtube.com/vi/s3wv0ZBprZg/hqdefault.jpg",
    "videos": [
      {
        "title": "Listrik Dinamis • Part 1: Hukum Ohm, Hukum Coulomb, dan Resistor",
        "id": "s3wv0ZBprZg",
        "thumbnail": "https://img.youtube.com/vi/s3wv0ZBprZg/hqdefault.jpg",
        "duration": "12:36"
      },
      {
        "title": "Listrik Dinamis • Part 2: Hukum Kirchhoff, Rangkaian Paralel dan Seri",
        "id": "7ZCciA6-02k",
        "thumbnail": "https://img.youtube.com/vi/7ZCciA6-02k/hqdefault.jpg",
        "duration": "18:23"
      },
      {
        "title": "Listrik Dinamis • Part 3: Energi Listrik, Daya, dan Efisiensi",
        "id": "YzItFjfskUo",
        "thumbnail": "https://img.youtube.com/vi/YzItFjfskUo/hqdefault.jpg",
        "duration": "21:40"
      }
    ],
  },
  {
    "title": "Kimia",
    "thumbnail": "https://img.youtube.com/vi/n63kHaAN7NU/hqdefault.jpg",
    "videos": [
      {
        "title": "Kimia Unsur • Part 1: Gas Mulia",
        "id": "n63kHaAN7NU",
        "thumbnail": "https://img.youtube.com/vi/n63kHaAN7NU/hqdefault.jpg",
        "duration": "11:31"
      },
      {
        "title": "Kimia Unsur • Part 2: Halogen",
        "id": "Fh7mCJHGmqM",
        "thumbnail": "https://img.youtube.com/vi/Fh7mCJHGmqM/hqdefault.jpg",
        "duration": "20:30"
      },
      {
        "title": "Kimia Unsur • Part 3: Logam Alkali",
        "id": "2soKDX2wWls",
        "thumbnail": "https://img.youtube.com/vi/2soKDX2wWls/hqdefault.jpg",
        "duration": "17:09"
      }

    ],
  },
  {
    "title": "Biologi",
    "thumbnail": "https://img.youtube.com/vi/zT7gNEiH_lc/hqdefault.jpg",
    "videos": [
      {
        "title": "HUKUM MENDEL: BIOLOGI KELAS 12 SMA • Part 1",
        "id": "zT7gNEiH_lc",
        "thumbnail": "https://img.youtube.com/vi/zT7gNEiH_lc/hqdefault.jpg",
        "duration": "16:39"
      },
      {
        "title": "HUKUM MENDEL: BIOLOGI KELAS 12 SMA • Part 2",
        "id": "oMGegA0mBbo",
        "thumbnail": "https://img.youtube.com/vi/oMGegA0mBbo/hqdefault.jpg",
        "duration": "21:46"
      },
      {
        "title": "HUKUM MENDEL: BIOLOGI KELAS 12 SMA • Part 3",
        "id": "W8BNvnGqJ-8",
        "thumbnail": "https://img.youtube.com/vi/W8BNvnGqJ-8/hqdefault.jpg",
        "duration": "22:41"
      }
    ],
  },
  {
    "title": "Ekonomi",
    "thumbnail": "https://img.youtube.com/vi/deO-g4ZDdNc/hqdefault.jpg",
    "videos": [
      {
      "title": "Akuntansi sebagai sistem informasi • Part 1",
      "id": "deO-g4ZDdNc",
      "thumbnail": "https://img.youtube.com/vi/deO-g4ZDdNc/hqdefault.jpg",
      "duration": "6:03"
    },
    {
      "title": "Pencatatan Transaksi Keuangan dalam Akuntansi • Part 2",
      "id": "Ycv60NBcINc",
      "thumbnail": "https://img.youtube.com/vi/Ycv60NBcINc/hqdefault.jpg",
      "duration": "9:46"
    },
    {
      "title": "Akuntansi untuk Bisnis Kecil dan Menengah • Part 3",
      "id": "sSHhXe3PfOo",
      "thumbnail": "https://img.youtube.com/vi/sSHhXe3PfOo/hqdefault.jpg",
      "duration": "6:13"
    }

    ],
  },
  {
    "title": "Bahasa Inggris",
    "thumbnail": "https://img.youtube.com/vi/Vegdxen0vto/hqdefault.jpg",
    "videos": [
      {
        "title": "Materi Bahasa Inggris Kelas XII Bab 9",
        "id": "Vegdxen0vto",
        "thumbnail": "https://img.youtube.com/vi/Vegdxen0vto/hqdefault.jpg",
        "duration": "30:57",
      },
      {
        "title": "Materi Bahasa Inggris Kelas XII Bab 8",
        "id": "LmmwrbGG5p8",
        "thumbnail": "https://img.youtube.com/vi/LmmwrbGG5p8/hqdefault.jpg",
        "duration": "24:56",
      },
      {
        "title": "Materi Bahasa Inggris Kelas XII Bab 9",
        "id": "yeotYW8ZvhQ",
        "thumbnail": "https://img.youtube.com/vi/yeotYW8ZvhQ/hqdefault.jpg",
        "duration": "37:17",
      }
    ],
  },
];
