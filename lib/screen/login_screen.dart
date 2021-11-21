import 'dart:convert';
import 'package:flutter/material.dart';
import '../network_utils/network.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  // final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_isLoading)
          ? _loadingScreen()
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _controllerEmail,
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    TextField(
                      controller: _controllerPassword,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          email = _controllerEmail.text;
                          password = _controllerPassword.text;
                          _login();
                        });
                      },
                      child: const Text('Kirim'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text('Register'),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = <String, String>{'email': email!, 'password': password!};

    var res = await Network().authData(data, '/auth/login');
    var body = json.decode(res.body);
    if (body != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['access_token']);
      localStorage.setString('userName', body['user']['name']);
      localStorage.setString('userEmail', body['user']['email']);
      print(body['user']['name']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      // print(body['error']);
      _showMsg(body['error']);
    }
  }

  Widget _loadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
