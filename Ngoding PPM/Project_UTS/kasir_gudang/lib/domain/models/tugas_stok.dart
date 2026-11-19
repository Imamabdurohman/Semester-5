class TugasStok {
  final String id;
  final String judul;
  final String keterangan;
  final String jenisTugas;
  final String? kontakSales;
  final bool isSelesai;

  const TugasStok({
    required this.id,
    required this.judul,
    required this.keterangan,
    required this.jenisTugas,
    this.kontakSales,
    this.isSelesai = false,
  });

  factory TugasStok.fromJson(Map<String, dynamic> json) {
    return TugasStok(
      id: json['id'] as String,
      judul: json['judul'] as String,
      keterangan: json['keterangan'] as String,
      jenisTugas: json['jenisTugas'] as String,
      kontakSales: json['kontakSales'] as String?,
      isSelesai: json['isSelesai'] as bool? ?? false,
    );
  }

  TugasStok copyWith({
    String? id,
    String? judul,
    String? keterangan,
    String? jenisTugas,
    String? kontakSales,
    bool? isSelesai,
  }) {
    return TugasStok(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      keterangan: keterangan ?? this.keterangan,
      jenisTugas: jenisTugas ?? this.jenisTugas,
      kontakSales: kontakSales ?? this.kontakSales,
      isSelesai: isSelesai ?? this.isSelesai,
    );
  }
}