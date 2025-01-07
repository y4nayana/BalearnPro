// data/dummy_courses.dart

class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int lessons;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.lessons,
  });
}

final List<Course> dummyCourses = [
  Course(
    id: 'c1',
    title: 'Matematika Dasar',
    description: 'Belajar konsep dasar matematika dengan mudah.',
    imageUrl: 'https://example.com/images/math.jpg',
    lessons: 10,
  ),
  Course(
    id: 'c2',
    title: 'Logika Pemrograman',
    description: 'Pelajari logika dasar pemrograman untuk pemula.',
    imageUrl: 'https://example.com/images/programming.jpg',
    lessons: 8,
  ),
  Course(
    id: 'c3',
    title: 'Bahasa Inggris',
    description: 'Tingkatkan kemampuan Bahasa Inggris Anda.',
    imageUrl: 'https://example.com/images/english.jpg',
    lessons: 12,
  ),
  Course(
    id: 'c4',
    title: 'Sains Dasar',
    description: 'Memahami sains dasar untuk kehidupan sehari-hari.',
    imageUrl: 'https://example.com/images/science.jpg',
    lessons: 15,
  ),
];
