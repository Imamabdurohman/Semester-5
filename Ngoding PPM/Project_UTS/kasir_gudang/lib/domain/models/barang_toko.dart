String formatRupiah(int nominal) {
  final isNegative = nominal < 0;
  final digits = nominal.abs().toString();
  final buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    final reverseIndex = digits.length - i;
    buffer.write(digits[i]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write('.');
    }
  }
  return '${isNegative ? '-Rp ' : 'Rp '}${buffer.toString()}';
}

class BarangToko {
  final String id;
  final String nama;
  final String kategori;
  final String satuan;
  final int hargaBeli;
  final int hargaJual;
  final int stokGudang;
  final int stokEtalase;
  final int minStok;
  final int terjualHariIni;
  final String namaSales;
  final String noTelpSales;

  const BarangToko({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.satuan,
    required this.hargaBeli,
    required this.hargaJual,
    required this.stokGudang,
    required this.stokEtalase,
    required this.minStok,
    required this.terjualHariIni,
    required this.namaSales,
    required this.noTelpSales,
  });

  int get totalStok => stokGudang + stokEtalase;
  bool get isStokHabis => totalStok == 0;
  bool get isStokMenipis => totalStok > 0 && totalStok <= minStok;
  bool get perluRestock => totalStok <= minStok;

  int get omzetHariIni => terjualHariIni * hargaJual;
  int get modalKembaliHariIni => terjualHariIni * hargaBeli;
  int get untungHariIni => omzetHariIni - modalKembaliHariIni;

  factory BarangToko.fromJson(Map<String, dynamic> json) {
    return BarangToko(
      id: json['id'] as String,
      nama: json['nama'] as String,
      kategori: json['kategori'] as String,
      satuan: json['satuan'] as String,
      hargaBeli: json['hargaBeli'] as int,
      hargaJual: json['hargaJual'] as int,
      stokGudang: json['stokGudang'] as int,
      stokEtalase: json['stokEtalase'] as int,
      minStok: json['minStok'] as int,
      terjualHariIni: json['terjualHariIni'] as int,
      namaSales: json['namaSales'] as String,
      noTelpSales: json['noTelpSales'] as String,
    );
  }

  BarangToko copyWith({
    String? id,
    String? nama,
    String? kategori,
    String? satuan,
    int? hargaBeli,
    int? hargaJual,
    int? stokGudang,
    int? stokEtalase,
    int? minStok,
    int? terjualHariIni,
    String? namaSales,
    String? noTelpSales,
  }) {
    return BarangToko(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      kategori: kategori ?? this.kategori,
      satuan: satuan ?? this.satuan,
      hargaBeli: hargaBeli ?? this.hargaBeli,
      hargaJual: hargaJual ?? this.hargaJual,
      stokGudang: stokGudang ?? this.stokGudang,
      stokEtalase: stokEtalase ?? this.stokEtalase,
      minStok: minStok ?? this.minStok,
      terjualHariIni: terjualHariIni ?? this.terjualHariIni,
      namaSales: namaSales ?? this.namaSales,
      noTelpSales: noTelpSales ?? this.noTelpSales,
    );
  }
}