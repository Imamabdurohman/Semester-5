import 'package:flutter/foundation.dart';
import '../../domain/models/tugas_stok.dart';
import '../services/kasir_gudang_service.dart';

class TugasStokRepository extends ChangeNotifier {
  final KasirGudangService _service;
  List<TugasStok> _items = [];

  TugasStokRepository(this._service);

  List<TugasStok> get items => List.unmodifiable(_items);

  int get jumlahBelumSelesai =>
      _items.where((tugas) => !tugas.isSelesai).length;

  Future<List<TugasStok>> getAllTugas({bool forceRefresh = false}) async {
    if (_items.isEmpty || forceRefresh) {
      _items = await _service.fetchTugasStok();
      notifyListeners();
    }
    return List.unmodifiable(_items);
  }

  void toggleSelesai(String id) {
    final index = _items.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final current = _items[index];
    _items[index] = current.copyWith(isSelesai: !current.isSelesai);
    notifyListeners();
  }

  void tambahTugasRestockOtomatis({
    required String namaBarang,
    required int sisaStok,
    required String namaSales,
    required String noTelpSales,
  }) {
    final sudahAda = _items.any(
      (t) => !t.isSelesai && t.judul.contains(namaBarang),
    );
    if (sudahAda) return;

    final statusLabel = sisaStok == 0 ? 'STOK HABIS' : 'Menipis';
    final tugasBaru = TugasStok(
      id: 'auto_${DateTime.now().millisecondsSinceEpoch}',
      judul: 'Kulakan $namaBarang ($statusLabel)',
      keterangan:
          'Total stok tersisa $sisaStok unit. Segera hubungi $namaSales.',
      jenisTugas: 'Restock Gudang',
      kontakSales: '$namaSales -$noTelpSales',
      isSelesai: false,
    );
    _items.insert(0, tugasBaru);
    notifyListeners();
  }
}