import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balearnpro2/screens/Login/login_screen.dart';
import 'package:balearnpro2/screens/lesson_screen.dart';
import 'package:balearnpro2/screens/video/video_screen.dart';
import 'package:balearnpro2/screens/chat/kontak_screen.dart';
import 'package:balearnpro2/screens/Kalkulator/kalkulator_screen.dart';
import 'package:balearnpro2/screens/Notes/note_screen.dart';
import 'package:balearnpro2/screens/profile_page.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  HomeScreen({required this.uid});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "User";
  int _currentIndex = 0;
  bool isDarkMode = false; // Default mode adalah light mode

  late List<Widget> _pages;

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

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _pages = [
      HomeContent(
        onLessonTap: _handleLessonTap,
        onPlaylistTap: _handlePlaylistTap,
        username: username, // Pastikan username dikirim
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
    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            _getAppBarTitle(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: _buildDrawer(),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages.map((page) {
            if (_currentIndex == 0) {
              return HomeContent(
                onLessonTap: _handleLessonTap,
                onPlaylistTap: _handlePlaylistTap,
                username: username, // Pastikan username dikirim
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
      ),
    );
  }

  Widget _buildDrawer() {
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
              Navigator.pop(context); // Tutup drawer
              final updatedData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(uid: widget.uid),
                ),
              );

              // Perbarui nama jika ada perubahan
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
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => _confirmLogout(context), // Pop-up konfirmasi logout
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
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Mata Pelajaran',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildLessonTile('Matematika', Icons.calculate, onPlaylistTap, context),
            _buildLessonTile('Fisika', Icons.lightbulb, onPlaylistTap, context),
            _buildLessonTile('Biologi', Icons.biotech, onPlaylistTap, context),
            _buildLessonTile('Ekonomi', Icons.attach_money, onPlaylistTap, context),
            _buildLessonTile('Kimia', Icons.science, onPlaylistTap, context),
            _buildLessonTile('Bahasa Inggris', Icons.language, onPlaylistTap, context),
          ],
        ),
      ],
    );
  }

  Widget _buildLessonTile(
      String lesson, IconData icon, Function(String) onTap, BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(lesson),
      child: Card(
        color: Theme.of(context).cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Theme.of(context).iconTheme.color),
            SizedBox(height: 8),
            Text(
              lesson,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
