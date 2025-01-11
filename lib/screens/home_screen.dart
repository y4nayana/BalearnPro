import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balearnpro2/screens/Login/login_screen.dart';
import 'package:balearnpro2/screens/lesson_screen.dart';
import 'package:balearnpro2/screens/video_screen.dart';
import 'package:balearnpro2/screens/chat/kontak_screen.dart';
import 'package:balearnpro2/screens/Kalkulator/kalkulator_screen.dart';
import 'package:balearnpro2/screens/Notes/note_screen.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  HomeScreen({required this.uid});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "User";
  int _currentIndex = 0;

  late final List<Widget> _pages;

  // Fungsi untuk membuat huruf depan kapital
  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  Future<void> _fetchUsername() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          String firstName = userDoc['firstName'] ?? '';
          String lastName = userDoc['lastName'] ?? '';
          username = "${capitalize(firstName)} ${capitalize(lastName)}";
        });
      }
    } catch (e) {
      print("Error fetching username: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _pages = [
      HomeContent(
        onLessonTap: _handleLessonTap,
        username: username,
      ),
      KontakScreen(currentUserId: widget.uid),
      KalkulatorScreen(),
      VideoScreen(),
      NoteScreen(),
    ];
  }

  void _handleLessonTap(String lesson) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonScreen(lessonName: lesson),
      ),
    );
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return "Home";
      case 1:
        return "Chat";
      case 2:
        return "Kalkulator";
      case 3:
        return "Video";
      case 4:
        return "Catatan";
      default:
        return "Home";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_getAppBarTitle()),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages.map((page) {
          if (_currentIndex == 0) {
            return HomeContent(
              onLessonTap: _handleLessonTap,
              username: username,
            );
          }
          return page;
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Kalkulator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt),
            label: 'Catatan',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final Function(String lesson) onLessonTap;
  final String username;

  HomeContent({required this.onLessonTap, required this.username});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Welcome, $username!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Mata Pelajaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildLessonTile('Matematika', Icons.calculate),
            _buildLessonTile('Fisika', Icons.science),
            _buildLessonTile('Biologi', Icons.biotech),
            _buildLessonTile('Ekonomi', Icons.attach_money),
            _buildLessonTile('Geografi', Icons.public),
            _buildLessonTile('Bahasa Inggris', Icons.language),
          ],
        ),
      ],
    );
  }

  Widget _buildLessonTile(String lesson, IconData icon) {
    return GestureDetector(
      onTap: () => onLessonTap(lesson),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.blue),
            SizedBox(height: 8),
            Text(
              lesson,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
