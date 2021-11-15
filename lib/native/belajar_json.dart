import 'dart:convert';

void main() {
  String teks =
      '{"id": 8, "nama_layanan": "Tebas Rumputan","deskripsi_layanan": "Menebas Rumput","created_at": "2021-11-09T02:33:02.000000Z","updated_at": "2021-11-09T02:33:02.000000Z"}';
  Map hasil = jsonDecode(teks);
  print(hasil['deskripsi_layanan']);
}
