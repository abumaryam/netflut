import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _serverAddress = 'https://alamatserver';
  final String _url = '/cybercampus/public/api';

  String? token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
  }

  authData(data, apiUrl) async {
    var fullUrl = _serverAddress + _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeadersNoAuth());
  }

  getData(apiUrl) async {
    var fullUrl = _serverAddress + _url + apiUrl;
    await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  _setHeadersNoAuth() => <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
}
