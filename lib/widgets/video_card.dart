// widgets/video_card.dart

import 'package:flutter/material.dart';
import '../../models/dummy_videos.dart';
import '../screens/video/video_player_screen.dart';

class VideoCard extends StatelessWidget {
  final Video video;

  VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Image.network(
          video.thumbnail,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(video.title),
        subtitle: Text('Watch Now'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(videoUrl: video.url),
            ),
          );
        },
      ),
    );
  }
}
