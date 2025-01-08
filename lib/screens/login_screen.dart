import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart'; // Pastikan ini sesuai path
import 'register_screen.dart'; // Pastikan ini sesuai path

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _pageController = PageController(); // PageController untuk swipe
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoginPage = true;

  // Fungsi untuk login
  void _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email dan password tidak boleh kosong")),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Berhasil login, arahkan ke HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(uid: userCredential.user!.uid),
        ),
      );
    } catch (e) {
      String errorMessage = "Terjadi kesalahan saat login.";
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = "Pengguna tidak ditemukan!";
        } else if (e.code == 'wrong-password') {
          errorMessage = "Password salah!";
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  // Fungsi untuk mengubah halaman (Login/Register)
  void _onTabChange(int index) {
    setState(() {
      isLoginPage = index == 0;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 40),
          _buildTabs(), // Tab Login dan Register
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onTabChange,
              children: [
                _buildLoginPage(), // Halaman Login
                RegisterScreen(pageController: _pageController), // Halaman Register
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat tab Login dan Register
  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _onTabChange(0),
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isLoginPage ? Colors.green : Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () => _onTabChange(1),
          child: Text(
            "Register",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: !isLoginPage ? Colors.green : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  // Halaman Login
  Widget _buildLoginPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email Address",
              prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: passwordController,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
