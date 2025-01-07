// screens/course/course_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:balearnpro/data/dummy_courses.dart';
import 'package:balearnpro/data/dummy_videos.dart';


class CourseDetailScreen extends StatelessWidget {
  final String courseId;

  CourseDetailScreen({required this.courseId});

  @override
  Widget build(BuildContext context) {
    final selectedCourse = dummyCourses.firstWhere((course) => course.id == courseId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCourse.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              selectedCourse.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              selectedCourse.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Lessons: ${selectedCourse.lessons}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              selectedCourse.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Enrolled in ${selectedCourse.title}!')),
                );
              },
              child: Text('Enroll Now'),
            ),
          ],
        ),
      ),
    );
  }
}
