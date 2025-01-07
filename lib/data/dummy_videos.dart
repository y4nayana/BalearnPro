// data/dummy_videos.dart

class Video {
  final String id;
  final String title;
  final String url;
  final String thumbnail;

  Video({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
  });
}

final List<Video> dummyVideos = [
  Video(
    id: 'v1',
    title: 'Introduction to Mathematics',
    url: 'https://www.youtube.com/watch?v=example1',
    thumbnail: 'https://example.com/images/thumb_math.jpg',
  ),
  Video(
    id: 'v2',
    title: 'Programming Basics',
    url: 'https://www.youtube.com/watch?v=example2',
    thumbnail: 'https://example.com/images/thumb_programming.jpg',
  ),
  Video(
    id: 'v3',
    title: 'English Grammar Tips',
    url: 'https://www.youtube.com/watch?v=example3',
    thumbnail: 'https://example.com/images/thumb_english.jpg',
  ),
  Video(
    id: 'v4',
    title: 'Science Experiments for Beginners',
    url: 'https://www.youtube.com/watch?v=example4',
    thumbnail: 'https://example.com/images/thumb_science.jpg',
  ),
];
