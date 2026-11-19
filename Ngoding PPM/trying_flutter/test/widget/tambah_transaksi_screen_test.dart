import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trying_flutter/sesi_9/domain/models/transaksi.dart';
import 'package:trying_flutter/sesi_9/ui/kas/kas_view_model.dart';
import 'package:trying_flutter/sesi_9/ui/kas/tambah_transaksi_screen.dart';

void main() {
  group('TambahTransaksiScreen Widget Tests', () {
    testWidgets('1. Menampilkan semua kolom input dan tombol Simpan',
        (WidgetTester tester) async {
      final viewModel = KasViewModel();

      await tester.pumpWidget(
        MaterialApp(
          home: TambahTransaksiScreen(viewModel: viewModel),
        ),
      );

      expect(find.byKey(const Key('field_keterangan')), findsOneWidget);
      expect(find.byKey(const Key('field_nominal')), findsOneWidget);
      expect(find.byKey(const Key('dropdown_jenis')), findsOneWidget);
      expect(find.byKey(const Key('field_tanggal')), findsOneWidget);
      expect(find.byKey(const Key('btn_simpan')), findsOneWidget);
    });

    testWidgets('2. Menampilkan pesan error validasi ketika form kosong disubmit',
        (WidgetTester tester) async {
      final viewModel = KasViewModel();

      await tester.pumpWidget(
        MaterialApp(
          home: TambahTransaksiScreen(viewModel: viewModel),
        ),
      );

      final btnSimpan = find.byKey(const Key('btn_simpan'));
      await tester.ensureVisible(btnSimpan);
      await tester.tap(btnSimpan);
      await tester.pumpAndSettle();

      expect(find.text('Keterangan wajib diisi'), findsOneWidget);
      expect(find.text('Nominal wajib diisi'), findsOneWidget);
      expect(viewModel.daftarTransaksi, isEmpty);
    });

    testWidgets('3. Menolak nominal nol atau negatif pada form',
        (WidgetTester tester) async {
      final viewModel = KasViewModel();

      await tester.pumpWidget(
        MaterialApp(
          home: TambahTransaksiScreen(viewModel: viewModel),
        ),
      );

      await tester.enterText(
          find.byKey(const Key('field_keterangan')), 'Tes Nominal Nol');
      await tester.enterText(find.byKey(const Key('field_nominal')), '0');

      final btnSimpan = find.byKey(const Key('btn_simpan'));
      await tester.ensureVisible(btnSimpan);
      await tester.tap(btnSimpan);
      await tester.pumpAndSettle();

      expect(find.text('Nominal harus lebih dari nol'), findsOneWidget);
      expect(viewModel.daftarTransaksi, isEmpty);
    });

    testWidgets(
        '4. Menolak pengeluaran melebihi saldo dan menyimpan transaksi valid',
        (WidgetTester tester) async {
      final viewModel = KasViewModel();
      viewModel.tambahTransaksi(
        keterangan: 'Saldo Awal',
        nominal: 100000,
        jenis: JenisTransaksi.pemasukan,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: TambahTransaksiScreen(viewModel: viewModel),
        ),
      );

      await tester.enterText(
          find.byKey(const Key('field_keterangan')), 'Beli Barang Mahal');
      await tester.enterText(find.byKey(const Key('field_nominal')), '250000');

      await tester.tap(find.byKey(const Key('dropdown_jenis')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('item_pengeluaran')).last);
      await tester.pumpAndSettle();

      final btnSimpan = find.byKey(const Key('btn_simpan'));
      await tester.ensureVisible(btnSimpan);
      await tester.tap(btnSimpan);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('text_error_saldo')), findsOneWidget);
      expect(viewModel.saldo, 100000.0);

      await tester.enterText(find.byKey(const Key('field_nominal')), '40000');
      await tester.ensureVisible(btnSimpan);
      await tester.tap(btnSimpan);
      await tester.pumpAndSettle();

      expect(viewModel.saldo, 60000.0);
      expect(viewModel.daftarTransaksi.length, 2);
    });
  });
}