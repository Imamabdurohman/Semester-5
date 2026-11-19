import 'package:flutter_test/flutter_test.dart';
import 'package:trying_flutter/sesi_9/domain/kas_calculator.dart';
import 'package:trying_flutter/sesi_9/domain/models/transaksi.dart';

void main() {
  late KasCalculator calculator;

  setUp(() {
    calculator = KasCalculator();
  });

  group('KasCalculator Unit Tests', () {
    test('1. Daftar transaksi kosong menghasilkan saldo 0', () {
      final List<Transaksi> kosong = [];
      expect(calculator.hitungSaldo(kosong), 0.0);
    });

    test('2. Daftar transaksi kosong menghasilkan total pemasukan dan pengeluaran 0', () {
      final List<Transaksi> kosong = [];
      expect(calculator.totalPemasukan(kosong), 0.0);
      expect(calculator.totalPengeluaran(kosong), 0.0);
    });

    test('3. Menghitung total pemasukan dengan benar dari beberapa transaksi', () {
      final daftar = [
        Transaksi(
          id: '1',
          keterangan: 'Iuran Kas',
          nominal: 200000,
          jenis: JenisTransaksi.pemasukan,
          tanggal: DateTime(2026, 11, 1),
        ),
        Transaksi(
          id: '2',
          keterangan: 'Dana Kampus',
          nominal: 350000,
          jenis: JenisTransaksi.pemasukan,
          tanggal: DateTime(2026, 11, 2),
        ),
        Transaksi(
          id: '3',
          keterangan: 'Print Proposal',
          nominal: 50000,
          jenis: JenisTransaksi.pengeluaran,
          tanggal: DateTime(2026, 11, 3),
        ),
      ];

      expect(calculator.totalPemasukan(daftar), 550000.0);
    });

    test('4. Menghitung total pengeluaran dengan benar dari beberapa transaksi', () {
      final daftar = [
        Transaksi(
          id: '1',
          keterangan: 'Iuran Kas',
          nominal: 500000,
          jenis: JenisTransaksi.pemasukan,
          tanggal: DateTime(2026, 11, 1),
        ),
        Transaksi(
          id: '2',
          keterangan: 'Konsumsi Rapat',
          nominal: 75000,
          jenis: JenisTransaksi.pengeluaran,
          tanggal: DateTime(2026, 11, 2),
        ),
        Transaksi(
          id: '3',
          keterangan: 'Spanduk Acara',
          nominal: 125000,
          jenis: JenisTransaksi.pengeluaran,
          tanggal: DateTime(2026, 11, 3),
        ),
      ];

      expect(calculator.totalPengeluaran(daftar), 200000.0);
    });

    test('5. Menghitung saldo akhir dengan benar (pemasukan - pengeluaran)', () {
      final daftar = [
        Transaksi(
          id: '1',
          keterangan: 'Pemasukan Awal',
          nominal: 1000000,
          jenis: JenisTransaksi.pemasukan,
          tanggal: DateTime(2026, 11, 1),
        ),
        Transaksi(
          id: '2',
          keterangan: 'Beli Perlengkapan',
          nominal: 325000,
          jenis: JenisTransaksi.pengeluaran,
          tanggal: DateTime(2026, 11, 5),
        ),
      ];

      expect(calculator.hitungSaldo(daftar), 675000.0);
    });

    test('6. Menolak transaksi dengan nominal nol (0)', () {
      final transaksiNol = Transaksi(
        id: '1',
        keterangan: 'Tes Nominal Nol',
        nominal: 0,
        jenis: JenisTransaksi.pemasukan,
        tanggal: DateTime(2026, 11, 10),
      );

      expect(
        () => calculator.validasiTransaksi(transaksiNol, 100000),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('7. Menolak transaksi dengan nominal negatif', () {
      final transaksiNegatif = Transaksi(
        id: '1',
        keterangan: 'Tes Nominal Negatif',
        nominal: -50000,
        jenis: JenisTransaksi.pemasukan,
        tanggal: DateTime(2026, 11, 10),
      );

      expect(
        () => calculator.validasiTransaksi(transaksiNegatif, 100000),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('8. Menolak pengeluaran yang melebihi saldo saat ini', () {
      final pengeluaranBerlebih = Transaksi(
        id: '1',
        keterangan: 'Beli Proyektor',
        nominal: 300000,
        jenis: JenisTransaksi.pengeluaran,
        tanggal: DateTime(2026, 11, 10),
      );

      expect(
        () => calculator.validasiTransaksi(pengeluaranBerlebih, 250000),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('9. Nilai batas: pengeluaran tepat sama dengan saldo diterima dan saldo menjadi 0', () {
      final pemasukan = Transaksi(
        id: '1',
        keterangan: 'Kas Masuk',
        nominal: 250000,
        jenis: JenisTransaksi.pemasukan,
        tanggal: DateTime(2026, 11, 10),
      );
      final pengeluaranTepat = Transaksi(
        id: '2',
        keterangan: 'Kas Keluar Maksimal',
        nominal: 250000,
        jenis: JenisTransaksi.pengeluaran,
        tanggal: DateTime(2026, 11, 11),
      );

      final saldoAwal = calculator.hitungSaldo([pemasukan]);
      expect(
        () => calculator.validasiTransaksi(pengeluaranTepat, saldoAwal),
        returnsNormally,
      );

      final saldoAkhir = calculator.hitungSaldo([pemasukan, pengeluaranTepat]);
      expect(saldoAkhir, 0.0);
    });

    test('10. Menerima pemasukan saat saldo awal 0', () {
      final pemasukanBaru = Transaksi(
        id: '1',
        keterangan: 'Saldo Pertama',
        nominal: 150000,
        jenis: JenisTransaksi.pemasukan,
        tanggal: DateTime(2026, 11, 12),
      );

      expect(
        () => calculator.validasiTransaksi(pemasukanBaru, 0.0),
        returnsNormally,
      );
      expect(calculator.hitungSaldo([pemasukanBaru]), 150000.0);
    });
  });
}