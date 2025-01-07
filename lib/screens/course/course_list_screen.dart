// screens/course/course_list_screen.dart

import 'package:flutter/material.dart';
import 'package:balearnpro/data/dummy_courses.dart';
import 'package:balearnpro/data/dummy_videos.dart';
import 'course_detail_screen.dart';

class CourseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Courses'),
      ),
      body: ListView.builder(
        itemCount: dummyCourses.length,
        itemBuilder: (context, index) {
          final course = dummyCourses[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.network(
                course.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(course.title),
              subtitle: Text('Lessons: ${course.lessons}'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailScreen(courseId: course.id),
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