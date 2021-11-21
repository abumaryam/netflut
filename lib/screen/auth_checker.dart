import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  _AuthCheckerState createState() {
    return _AuthCheckerState();
  }
}

class _AuthCheckerState extends State<AuthChecker> {
  bool isAuth = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isAuth) ? const HomeScreen() : const LoginScreen();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }
}
