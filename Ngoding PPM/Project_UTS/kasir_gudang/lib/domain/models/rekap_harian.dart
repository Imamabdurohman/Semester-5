class RekapHarian {
  final String id;
  final String tanggal;
  final int totalItemTerjual;
  final int totalUangMasuk;
  final int totalModalKembali;
  final int totalUntungBersih;
  final String ringkasanBarang;

  const RekapHarian({
    required this.id,
    required this.tanggal,
    required this.totalItemTerjual,
    required this.totalUangMasuk,
    required this.totalModalKembali,
    required this.totalUntungBersih,
    required this.ringkasanBarang,
  });

  factory RekapHarian.fromJson(Map<String, dynamic> json) {
    return RekapHarian(
      id: json['id'] as String,
      tanggal: json['tanggal'] as String,
      totalItemTerjual: json['totalItemTerjual'] as int,
      totalUangMasuk: json['totalUangMasuk'] as int,
      totalModalKembali: json['totalModalKembali'] as int,
      totalUntungBersih: json['totalUntungBersih'] as int,
      ringkasanBarang: json['ringkasanBarang'] as String,
    );
  }

  RekapHarian copyWith({
    String? id,
    String? tanggal,
    int? totalItemTerjual,
    int? totalUangMasuk,
    int? totalModalKembali,
    int? totalUntungBersih,
    String? ringkasanBarang,
  }) {
    return RekapHarian(
      id: id ?? this.id,
      tanggal: tanggal ?? this.tanggal,
      totalItemTerjual: totalItemTerjual ?? this.totalItemTerjual,
      totalUangMasuk: totalUangMasuk ?? this.totalUangMasuk,
      totalModalKembali: totalModalKembali ?? this.totalModalKembali,
      totalUntungBersih: totalUntungBersih ?? this.totalUntungBersih,
      ringkasanBarang: ringkasanBarang ?? this.ringkasanBarang,
    );
  }
}