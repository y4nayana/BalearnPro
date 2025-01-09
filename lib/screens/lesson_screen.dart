import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  final String lessonName;

  LessonScreen({required this.lessonName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lessonName),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          'Page for $lessonName',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
