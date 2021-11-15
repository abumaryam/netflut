import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/layanan.dart';

Future<Layanan> fetchLayanan() async {
  final response = await http.get(Uri.parse(
      'https://e20e-2404-c0-8410-26dc-2084-51c2-f769-d056.ngrok.io/cybercampus/public/api/layanan/8'));

  if (response.statusCode == 200) {
    return Layanan.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Layanan');
  }
}

class LayananScreen extends StatefulWidget {
  const LayananScreen({Key? key}) : super(key: key);

  @override
  _LayananScreenState createState() => _LayananScreenState();
}

class _LayananScreenState extends State<LayananScreen> {
  late Future<Layanan> futureLayanan;

  @override
  void initState() {
    super.initState();
    futureLayanan = fetchLayanan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Layanan>(
          future: futureLayanan,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.namaLayanan);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
