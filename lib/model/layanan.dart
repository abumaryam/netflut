class Layanan {
  final String namaLayanan;
  final int id;
  final String deskripsiLayanan;

  Layanan({
    required this.id,
    required this.namaLayanan,
    required this.deskripsiLayanan,
  });

  factory Layanan.fromJson(Map<String, dynamic> json) {
    return Layanan(
      namaLayanan: json['nama_layanan'],
      id: json['id'],
      deskripsiLayanan: json['deskripsi_layanan'],
    );
  }
}
