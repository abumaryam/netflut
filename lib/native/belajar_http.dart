import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  var fullUrl = 'https://alamatserver/cybercampus/public/api/auth/login';
  var data = <String, String>{
    'email': 'bayu@gmail.com',
    'password': 'password'
  };

  var res = await http.post(Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      });
  var body = json.decode(res.body);

  print(body['user']['name']);
}
