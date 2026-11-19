import 'package:flutter/foundation.dart';
import '../../data/repositories/transaksi_repository.dart';
import '../../domain/kas_calculator.dart';
import '../../domain/models/transaksi.dart';

class KasViewModel extends ChangeNotifier {
  final TransaksiRepository _repository;
  final KasCalculator _calculator;

  String? _errorMessage;

  KasViewModel({
    TransaksiRepository? repository,
    KasCalculator? calculator,
  })  : _calculator = calculator ?? KasCalculator(),
        _repository = repository ??
            TransaksiRepository(calculator: calculator ?? KasCalculator());

  List<Transaksi> get daftarTransaksi => _repository.getAll();

  double get totalPemasukan => _calculator.totalPemasukan(daftarTransaksi);

  double get totalPengeluaran => _calculator.totalPengeluaran(daftarTransaksi);

  double get saldo => _calculator.hitungSaldo(daftarTransaksi);

  String? get errorMessage => _errorMessage;

  void clearError() {
    _errorMessage = null;
  }

  bool tambahTransaksi({
    required String keterangan,
    required double nominal,
    required JenisTransaksi jenis,
    DateTime? tanggal,
  }) {
    try {
      _errorMessage = null;
      final transaksiBaru = Transaksi(
        id: 'TRX-${DateTime.now().microsecondsSinceEpoch}',
        keterangan: keterangan.trim(),
        nominal: nominal,
        jenis: jenis,
        tanggal: tanggal ?? DateTime.now(),
      );

      _repository.tambah(transaksiBaru);
      notifyListeners();
      return true;
    } on ArgumentError catch (e) {
      _errorMessage = e.message.toString();
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
      notifyListeners();
      return false;
    }
  }

  void hapusTransaksi(String id) {
    _repository.hapus(id);
    notifyListeners();
  }
}