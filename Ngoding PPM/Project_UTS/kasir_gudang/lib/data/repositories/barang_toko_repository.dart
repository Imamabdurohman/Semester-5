import 'package:flutter/foundation.dart';
import '../../domain/models/barang_toko.dart';
import '../services/kasir_gudang_service.dart';

class BarangTokoRepository extends ChangeNotifier {
  final KasirGudangService _service;
  List<BarangToko> _items = [];

  BarangTokoRepository(this._service);

  List<BarangToko> get items => List.unmodifiable(_items);

  Future<List<BarangToko>> getAllBarang({bool forceRefresh = false}) async {
    if (_items.isEmpty || forceRefresh) {
      _items = await _service.fetchBarangToko();
      notifyListeners();
    }
    return List.unmodifiable(_items);
  }

  void catatBarangMasukGudang({
    required String barangId,
    required int jumlahMasuk,
    required int hargaBeliBaru,
  }) {
    final index = _items.indexWhere((b) => b.id == barangId);
    if (index == -1 || jumlahMasuk <= 0) return;

    final current = _items[index];
    _items[index] = current.copyWith(
      stokGudang: current.stokGudang + jumlahMasuk,
      hargaBeli: hargaBeliBaru > 0 ? hargaBeliBaru : current.hargaBeli,
    );
    notifyListeners();
  }

  bool pindahGudangKeEtalase({
    required String barangId,
    required int jumlahPindah,
  }) {
    final index = _items.indexWhere((b) => b.id == barangId);
    if (index == -1 || jumlahPindah <= 0) return false;

    final current = _items[index];
    if (current.stokGudang < jumlahPindah) return false;

    _items[index] = current.copyWith(
      stokGudang: current.stokGudang - jumlahPindah,
      stokEtalase: current.stokEtalase + jumlahPindah,
    );
    notifyListeners();
    return true;
  }

  bool catatPenjualanKasir({
    required String barangId,
    required int jumlahJual,
  }) {
    final index = _items.indexWhere((b) => b.id == barangId);
    if (index == -1 || jumlahJual <= 0) return false;

    final current = _items[index];
    if (current.stokEtalase < jumlahJual) return false;

    _items[index] = current.copyWith(
      stokEtalase: current.stokEtalase - jumlahJual,
      terjualHariIni: current.terjualHariIni + jumlahJual,
    );
    notifyListeners();
    return true;
  }

  void resetPenjualanHariIni() {
    _items = _items
        .map((item) => item.copyWith(terjualHariIni: 0))
        .toList();
    notifyListeners();
  }
}