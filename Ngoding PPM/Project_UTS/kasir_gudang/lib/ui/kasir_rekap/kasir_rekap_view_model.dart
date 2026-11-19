import 'package:flutter/foundation.dart';
import '../../data/repositories/barang_toko_repository.dart';
import '../../data/repositories/rekap_harian_repository.dart';
import '../../data/repositories/tugas_stok_repository.dart';
import '../../domain/models/barang_toko.dart';
import '../../domain/models/rekap_harian.dart';

class KasirRekapViewModel extends ChangeNotifier {
  final BarangTokoRepository _barangRepository;
  final RekapHarianRepository _rekapRepository;
  final TugasStokRepository _tugasRepository;

  bool _isLoading = false;
  String? _error;
  List<BarangToko> _daftarBarang = [];
  List<RekapHarian> _riwayatRekap = [];

  KasirRekapViewModel({
    required BarangTokoRepository barangRepository,
    required RekapHarianRepository rekapRepository,
    required TugasStokRepository tugasRepository,
  })  : _barangRepository = barangRepository,
        _rekapRepository = rekapRepository,
        _tugasRepository = tugasRepository {
    _barangRepository.addListener(_onDataChanged);
    _rekapRepository.addListener(_onDataChanged);
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<BarangToko> get daftarBarang => _daftarBarang;
  List<RekapHarian> get riwayatRekap => _riwayatRekap;

  List<BarangToko> get barangTerjualHariIni =>
      _daftarBarang.where((b) => b.terjualHariIni > 0).toList();

  int get totalItemTerjualHariIni =>
      _daftarBarang.fold(0, (sum, b) => sum + b.terjualHariIni);

  int get totalOmzetHariIni =>
      _daftarBarang.fold(0, (sum, b) => sum + b.omzetHariIni);

  int get totalModalKembaliHariIni =>
      _daftarBarang.fold(0, (sum, b) => sum + b.modalKembaliHariIni);

  int get totalUntungHariIni =>
      _daftarBarang.fold(0, (sum, b) => sum + b.untungHariIni);

  Future<void> load({bool forceRefresh = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _barangRepository.getAllBarang(forceRefresh: forceRefresh),
        _rekapRepository.getAllRekap(forceRefresh: forceRefresh),
      ]);
      _daftarBarang = results[0] as List<BarangToko>;
      _riwayatRekap = results[1] as List<RekapHarian>;
    } catch (e) {
      _error = 'Gagal memuat data kasir & rekap: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String? catatTransaksiKasir({
    required String barangId,
    required int jumlahJual,
  }) {
    if (jumlahJual <= 0) {
      return 'Jumlah barang terjual harus lebih dari 0.';
    }

    final targetIndex = _daftarBarang.indexWhere((b) => b.id == barangId);
    if (targetIndex == -1) {
      return 'Barang tidak ditemukan.';
    }

    final target = _daftarBarang[targetIndex];
    if (target.stokEtalase < jumlahJual) {
      return 'Stok etalase ${target.nama} tidak cukup (sisa ${target.stokEtalase}). Pindahkan stok dari gudang terlebih dahulu.';
    }

    final berhasil = _barangRepository.catatPenjualanKasir(
      barangId: barangId,
      jumlahJual: jumlahJual,
    );

    if (!berhasil) {
      return 'Gagal mencatat transaksi kasir.';
    }

    final updated = _barangRepository.items.firstWhere((b) => b.id == barangId);
    if (updated.perluRestock) {
      _tugasRepository.tambahTugasRestockOtomatis(
        namaBarang: updated.nama,
        sisaStok: updated.totalStok,
        namaSales: updated.namaSales,
        noTelpSales: updated.noTelpSales,
      );
    }

    return null;
  }

  void inputBarangMasukGudang({
    required String barangId,
    required int jumlahMasuk,
    required int hargaBeliBaru,
  }) {
    _barangRepository.catatBarangMasukGudang(
      barangId: barangId,
      jumlahMasuk: jumlahMasuk,
      hargaBeliBaru: hargaBeliBaru,
    );
  }

  bool tutupTokoDanRekap({String? tanggalCustom}) {
    final totalItem = totalItemTerjualHariIni;
    if (totalItem == 0) return false;

    final ringkasan = barangTerjualHariIni
        .map((b) => '${b.nama} (${b.terjualHariIni} ${b.satuan})')
        .join(', ');

    final now = DateTime.now();
    final tanggalLabel =
        tanggalCustom ?? '${now.day}/${now.month}/${now.year} (Tutup Toko)';

    final rekapBaru = RekapHarian(
      id: 'rekap_${now.millisecondsSinceEpoch}',
      tanggal: tanggalLabel,
      totalItemTerjual: totalItem,
      totalUangMasuk: totalOmzetHariIni,
      totalModalKembali: totalModalKembaliHariIni,
      totalUntungBersih: totalUntungHariIni,
      ringkasanBarang: ringkasan,
    );

    _rekapRepository.tambahRekapTutupToko(rekapBaru);
    _barangRepository.resetPenjualanHariIni();
    return true;
  }

  void _onDataChanged() {
    _daftarBarang = _barangRepository.items;
    _riwayatRekap = _rekapRepository.items;
    notifyListeners();
  }

  @override
  void dispose() {
    _barangRepository.removeListener(_onDataChanged);
    _rekapRepository.removeListener(_onDataChanged);
    super.dispose();
  }
}