import 'package:flutter/material.dart';
import 'package:netflut/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Selamat Datang $name"),
            ElevatedButton(
              onPressed: () => logout(),
              child: const Text('Keluar'),
            ),
          ],
        ),
      ),
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('userName');
    localStorage.remove('userEmail');
    localStorage.remove('token');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? userName = localStorage.getString('userName');
    if (userName != null) {
      setState(() {
        name = userName;
      });
    }
  }
}
