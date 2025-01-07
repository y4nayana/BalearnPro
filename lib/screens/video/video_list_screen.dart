// screens/video/video_list_screen.dart

import 'package:flutter/material.dart';
import 'package:balearnpro/data/dummy_videos.dart';
import 'video_player_screen.dart';

class VideoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: ListView.builder(
        itemCount: dummyVideos.length,
        itemBuilder: (context, index) {
          final video = dummyVideos[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
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
        },
      ),
    );
  }
}
