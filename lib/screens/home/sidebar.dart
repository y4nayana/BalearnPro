// screens/home/sidebar.dart

import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://example.com/profile-picture.jpg'), // Replace with actual profile picture URL
                ),
                SizedBox(height: 10),
                Text(
                  'User Name', // Replace with dynamic user name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com', // Replace with dynamic user email
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Courses'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/courses');
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chat'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/chat');
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contacts'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/contacts');
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Calculator'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/calculator');
            },
          ),
          ListTile(
            leading: Icon(Icons.video_library),
            title: Text('Videos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/videos');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
