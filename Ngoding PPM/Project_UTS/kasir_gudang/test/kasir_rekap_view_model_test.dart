import 'package:flutter_test/flutter_test.dart';
import 'package:kasir_gudang/data/repositories/barang_toko_repository.dart';
import 'package:kasir_gudang/data/repositories/rekap_harian_repository.dart';
import 'package:kasir_gudang/data/repositories/tugas_stok_repository.dart';
import 'package:kasir_gudang/data/services/kasir_gudang_service.dart';
import 'package:kasir_gudang/ui/kasir_rekap/kasir_rekap_view_model.dart';

void main() {
  late KasirGudangService service;
  late BarangTokoRepository barangRepo;
  late RekapHarianRepository rekapRepo;
  late TugasStokRepository tugasRepo;
  late KasirRekapViewModel viewModel;

  setUp(() {
    service = const KasirGudangService(delay: Duration.zero);
    barangRepo = BarangTokoRepository(service);
    rekapRepo = RekapHarianRepository(service);
    tugasRepo = TugasStokRepository(service);
    viewModel = KasirRekapViewModel(
      barangRepository: barangRepo,
      rekapRepository: rekapRepo,
      tugasRepository: tugasRepo,
    );
  });

  tearDown(() {
    viewModel.dispose();
  });

  test('load() berhasil memuat daftar barang grosir dan riwayat rekap harian', () async {
    await viewModel.load();

    expect(viewModel.isLoading, false);
    expect(viewModel.error, isNull);
    expect(viewModel.daftarBarang.length, greaterThanOrEqualTo(5));
    expect(viewModel.riwayatRekap.length, greaterThanOrEqualTo(5));
  });

  test('catatTransaksiKasir mengurangi stok etalase dan menghitung laba bersih', () async {
    await viewModel.load();
    final omzetAwal = viewModel.totalOmzetHariIni;
    final untungAwal = viewModel.totalUntungHariIni;

    // Beras Premium 5kg (id: b1), hargaBeli: 64000, hargaJual: 72000 (untung 8000/sak)
    final error = viewModel.catatTransaksiKasir(barangId: 'b1', jumlahJual: 2);

    expect(error, isNull);
    expect(viewModel.totalOmzetHariIni, omzetAwal + (72000 * 2));
    expect(viewModel.totalUntungHariIni, untungAwal + (8000 * 2));
  });

  test('tutupTokoDanRekap menambahkan rekap harian baru dan mereset hitungan hari ini', () async {
    await viewModel.load();
    final jumlahRekapAwal = viewModel.riwayatRekap.length;

    final sukses = viewModel.tutupTokoDanRekap(tanggalCustom: '19 Nov 2026');

    expect(sukses, true);
    expect(viewModel.riwayatRekap.length, jumlahRekapAwal + 1);
    expect(viewModel.riwayatRekap.first.tanggal, '19 Nov 2026');
    expect(viewModel.totalItemTerjualHariIni, 0);
    expect(viewModel.totalOmzetHariIni, 0);
  });
}