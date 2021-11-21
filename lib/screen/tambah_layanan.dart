import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/layanan.dart';

Future<Layanan> createLayanan(
    String namaLayanan, String deskripsiLayanan) async {
  final response = await http.post(
    Uri.parse('https://alamatserver/cybercampus/public/api/layanan'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nama_layanan': namaLayanan,
      'deskripsi_layanan': deskripsiLayanan,
    }),
  );

  if (response.statusCode == 201) {
    return Layanan.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Layanan.');
  }
}

class TambahLayanan extends StatefulWidget {
  const TambahLayanan({Key? key}) : super(key: key);

  @override
  _TambahLayananState createState() {
    return _TambahLayananState();
  }
}

class _TambahLayananState extends State<TambahLayanan> {
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerDeskripsi = TextEditingController();
  Future<Layanan>? _futureLayanan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Data Example'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureLayanan == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controllerNama,
          decoration: const InputDecoration(hintText: 'Nama Layanan'),
        ),
        TextField(
          controller: _controllerDeskripsi,
          decoration: const InputDecoration(hintText: 'Deskripsi Layanan'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureLayanan = createLayanan(
                  _controllerNama.text, _controllerDeskripsi.text);
            });
          },
          child: const Text('Kirim'),
        ),
      ],
    );
  }

  FutureBuilder<Layanan> buildFutureBuilder() {
    return FutureBuilder<Layanan>(
      future: _futureLayanan,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.namaLayanan);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
