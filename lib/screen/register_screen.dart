import 'dart:convert';
import 'package:flutter/material.dart';
import '../network_utils/network.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  // final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  final TextEditingController _controllerName = TextEditingController();
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
                      controller: _controllerName,
                      decoration:
                          const InputDecoration(hintText: 'Nama Lengkap'),
                    ),
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
                          name = _controllerName.text;
                          _login();
                        });
                      },
                      child: const Text('Kirim'),
                    ),
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
    var data = <String, String>{
      'email': email!,
      'password': password!,
      'password_confirmation': password!,
      'name': name!
    };

    var res = await Network().authData(data, '/auth/register');
    var body = json.decode(res.body);
    if (body != null) {
      print(body['message']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
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
