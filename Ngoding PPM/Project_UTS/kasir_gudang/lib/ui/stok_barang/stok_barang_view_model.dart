import 'package:flutter/foundation.dart';
import '../../data/repositories/barang_toko_repository.dart';
import '../../domain/models/barang_toko.dart';

class StokBarangViewModel extends ChangeNotifier {
  final BarangTokoRepository _barangRepository;

  bool _isLoading = false;
  String? _error;
  String _kategoriDipilih = 'Sembako';
  List<BarangToko> _semuaBarang = [];

  StokBarangViewModel({
    required BarangTokoRepository barangRepository,
  }) : _barangRepository = barangRepository {
    _barangRepository.addListener(_onBarangChanged);
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get kategoriDipilih => _kategoriDipilih;

  List<BarangToko> get barangTersaring => _semuaBarang
      .where((item) => item.kategori == _kategoriDipilih)
      .toList();

  Future<void> load({bool forceRefresh = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _semuaBarang =
          await _barangRepository.getAllBarang(forceRefresh: forceRefresh);
    } catch (e) {
      _error = 'Gagal memuat data stok barang: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void ubahKategori(String kategori) {
    _kategoriDipilih = kategori;
    notifyListeners();
  }

  bool pindahKeEtalase(String barangId, int jumlah) {
    return _barangRepository.pindahGudangKeEtalase(
      barangId: barangId,
      jumlahPindah: jumlah,
    );
  }

  void tambahStokGudang(String barangId, int jumlahMasuk, int hargaBeliBaru) {
    _barangRepository.catatBarangMasukGudang(
      barangId: barangId,
      jumlahMasuk: jumlahMasuk,
      hargaBeliBaru: hargaBeliBaru,
    );
  }

  void _onBarangChanged() {
    _semuaBarang = _barangRepository.items;
    notifyListeners();
  }

  @override
  void dispose() {
    _barangRepository.removeListener(_onBarangChanged);
    super.dispose();
  }
}