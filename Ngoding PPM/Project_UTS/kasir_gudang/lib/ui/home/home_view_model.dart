import 'package:flutter/foundation.dart';
import '../../data/repositories/barang_toko_repository.dart';
import '../../data/repositories/tugas_stok_repository.dart';
import '../../domain/models/barang_toko.dart';
import '../../domain/models/tugas_stok.dart';

class HomeViewModel extends ChangeNotifier {
  final BarangTokoRepository _barangRepository;
  final TugasStokRepository _tugasRepository;

  bool _isLoading = false;
  String? _error;
  String _kategoriTerpilih = 'Sembako';
  List<BarangToko> _semuaBarang = [];
  List<TugasStok> _semuaTugas = [];

  HomeViewModel({
    required BarangTokoRepository barangRepository,
    required TugasStokRepository tugasRepository,
  })  : _barangRepository = barangRepository,
        _tugasRepository = tugasRepository {
    _barangRepository.addListener(_onDataChanged);
    _tugasRepository.addListener(_onDataChanged);
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get kategoriTerpilih => _kategoriTerpilih;

  List<String> get daftarKategori => const [
        'Sembako',
        'Minuman',
        'Makanan Ringan',
        'Kebutuhan Rumah',
      ];

  List<BarangToko> get barangPerKategori => _semuaBarang
      .where((b) => b.kategori == _kategoriTerpilih)
      .toList();

  List<BarangToko> get barangPerluRestock =>
      _semuaBarang.where((b) => b.perluRestock).toList();

  List<TugasStok> get tugasBelumSelesai =>
      _semuaTugas.where((t) => !t.isSelesai).toList();

  int get totalOmzetHariIni =>
      _semuaBarang.fold(0, (sum, item) => sum + item.omzetHariIni);

  int get totalUntungHariIni =>
      _semuaBarang.fold(0, (sum, item) => sum + item.untungHariIni);

  Future<void> load({bool forceRefresh = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _barangRepository.getAllBarang(forceRefresh: forceRefresh),
        _tugasRepository.getAllTugas(forceRefresh: forceRefresh),
      ]);
      _semuaBarang = results[0] as List<BarangToko>;
      _semuaTugas = results[1] as List<TugasStok>;
    } catch (e) {
      _error = 'Gagal memuat ringkasan toko: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void pilihKategori(String kategori) {
    _kategoriTerpilih = kategori;
    notifyListeners();
  }

  void toggleTugas(String id) {
    _tugasRepository.toggleSelesai(id);
  }

  void _onDataChanged() {
    _semuaBarang = _barangRepository.items;
    _semuaTugas = _tugasRepository.items;
    notifyListeners();
  }

  @override
  void dispose() {
    _barangRepository.removeListener(_onDataChanged);
    _tugasRepository.removeListener(_onDataChanged);
    super.dispose();
  }
}