import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';
import 'profile_page.dart';
import 'Login/login_screen.dart';
import 'lesson_screen.dart';
import 'video/video_screen.dart';
import 'chat/kontak_screen.dart';
import 'Kalkulator/kalkulator_screen.dart';
import 'Notes/note_screen.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  HomeScreen({required this.uid});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "User";
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _pages = [
      HomeContent(
        onLessonTap: _handleLessonTap,
        onPlaylistTap: _handlePlaylistTap,
        username: username,
      ),
      KontakScreen(currentUserId: widget.uid),
      KalkulatorScreen(),
      VideoScreen(),
      NoteScreen(),
    ];
  }

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
          _pages[0] = HomeContent(
            onLessonTap: _handleLessonTap,
            onPlaylistTap: _handlePlaylistTap,
            username: username,
          );
        });
      }
    } catch (e) {
      print("Error fetching username: $e");
    }
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi Logout"),
        content: Text("Apakah Anda yakin ingin keluar dari akun ini?"),
        actions: [
          TextButton(
            child: Text("Batal", style: TextStyle(color: Colors.grey)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Logout", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleLessonTap(String lesson) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonScreen(lessonName: lesson),
      ),
    );
  }

  void _handlePlaylistTap(String subject) {}

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
    final themeNotifier = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          _getAppBarTitle(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: _buildDrawer(themeNotifier),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
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

  Widget _buildDrawer(ThemeProvider themeNotifier) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            accountName: Text(
              username,
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              FirebaseAuth.instance.currentUser?.email ?? "Email tidak tersedia",
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                username.isNotEmpty ? username[0] : 'U',
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profil"),
            onTap: () async {
              Navigator.pop(context);

              final updatedData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(uid: widget.uid),
                ),
              );

              if (updatedData != null) {
                setState(() {
                  username =
                      "${capitalize(updatedData['firstName'])} ${capitalize(updatedData['lastName'])}";
                  _pages[0] = HomeContent(
                    onLessonTap: _handleLessonTap,
                    onPlaylistTap: _handlePlaylistTap,
                    username: username,
                  );
                });
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: themeNotifier.isDarkMode,
              onChanged: (value) {
                themeNotifier.toggleTheme();
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => _confirmLogout(context),
          ),
        ],
      ),
    );
  }
}
class HomeContent extends StatelessWidget {
  final Function(String lesson) onLessonTap;
  final Function(String subject) onPlaylistTap;
  final String username;

  HomeContent({
    required this.onLessonTap,
    required this.onPlaylistTap,
    required this.username,
  });

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
            ),
          ),
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildLessonTile('Matematika', Icons.calculate, onLessonTap),
            _buildLessonTile('Fisika', Icons.lightbulb, onLessonTap),
            _buildLessonTile('Biologi', Icons.biotech, onLessonTap),
            _buildLessonTile('Ekonomi', Icons.attach_money, onLessonTap),
            _buildLessonTile('Kimia', Icons.science, onLessonTap),
            _buildLessonTile('Bahasa Inggris', Icons.language, onLessonTap),
          ],
        ),
      ],
    );
  }

  Widget _buildLessonTile(String lesson, IconData icon, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(lesson),
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
