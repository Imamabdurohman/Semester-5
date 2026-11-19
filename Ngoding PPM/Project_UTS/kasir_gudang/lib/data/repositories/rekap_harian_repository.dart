import 'package:flutter/foundation.dart';
import '../../domain/models/rekap_harian.dart';
import '../services/kasir_gudang_service.dart';

class RekapHarianRepository extends ChangeNotifier {
  final KasirGudangService _service;
  List<RekapHarian> _items = [];

  RekapHarianRepository(this._service);

  List<RekapHarian> get items => List.unmodifiable(_items);

  Future<List<RekapHarian>> getAllRekap({bool forceRefresh = false}) async {
    if (_items.isEmpty || forceRefresh) {
      _items = await _service.fetchRekapHarian();
      notifyListeners();
    }
    return List.unmodifiable(_items);
  }

  void tambahRekapTutupToko(RekapHarian rekapBaru) {
    _items.insert(0, rekapBaru);
    notifyListeners();
  }
}