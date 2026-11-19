import 'models/transaksi.dart';

class KasCalculator {
  /// Menghitung total pemasukan dari daftar transaksi
  double totalPemasukan(List<Transaksi> daftarTransaksi) {
    return daftarTransaksi
        .where((t) => t.jenis == JenisTransaksi.pemasukan)
        .fold(0.0, (sum, item) => sum + item.nominal);
  }

  /// Menghitung total pengeluaran dari daftar transaksi
  double totalPengeluaran(List<Transaksi> daftarTransaksi) {
    return daftarTransaksi
        .where((t) => t.jenis == JenisTransaksi.pengeluaran)
        .fold(0.0, (sum, item) => sum + item.nominal);
  }

  /// Menghitung saldo akhir (Total Pemasukan - Total Pengeluaran)
  double hitungSaldo(List<Transaksi> daftarTransaksi) {
    return totalPemasukan(daftarTransaksi) - totalPengeluaran(daftarTransaksi);
  }

  /// Validasi aturan bisnis transaksi:
  /// - Tolak nominal nol atau negatif
  /// - Tolak pengeluaran yang melebihi saldo saat ini
  void validasiTransaksi(Transaksi transaksi, double saldoSaatIni) {
    if (transaksi.nominal <= 0) {
      throw ArgumentError('Nominal transaksi harus lebih besar dari nol.');
    }

    if (transaksi.jenis == JenisTransaksi.pengeluaran &&
        transaksi.nominal > saldoSaatIni) {
      throw ArgumentError(
        'Pengeluaran melebihi saldo yang tersedia (Saldo: Rp ${saldoSaatIni.toInt()}).',
      );
    }
  }
}