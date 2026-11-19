import '../../domain/kas_calculator.dart';
import '../../domain/models/transaksi.dart';

class TransaksiRepository {
  final List<Transaksi> _daftarTransaksi = [];
  final KasCalculator _calculator;

  TransaksiRepository({
    KasCalculator? calculator,
    List<Transaksi>? initialData,
  }) : _calculator = calculator ?? KasCalculator() {
    if (initialData != null) {
      _daftarTransaksi.addAll(initialData);
    }
  }

  List<Transaksi> getAll() {
    return List.unmodifiable(_daftarTransaksi);
  }

  void tambah(Transaksi transaksi) {
    final saldoSekarang = _calculator.hitungSaldo(_daftarTransaksi);
    _calculator.validasiTransaksi(transaksi, saldoSekarang);
    _daftarTransaksi.insert(0, transaksi);
  }

  void hapus(String id) {
    _daftarTransaksi.removeWhere((t) => t.id == id);
  }

  void clear() {
    _daftarTransaksi.clear();
  }
}