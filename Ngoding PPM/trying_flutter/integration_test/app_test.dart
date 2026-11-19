import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trying_flutter/sesi_9/nusa_kas_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Alur lengkap: tambah transaksi pemasukan dan pengeluaran lalu periksa saldo',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NusaKasApp());
    await tester.pumpAndSettle();

    // Pastikan saldo awal Rp 0
    expect(find.text('Rp 0'), findsWidgets);

    // 1. Tambah Transaksi Pertama: Pemasukan Rp 500.000
    await tester.tap(find.byKey(const Key('fab_tambah_transaksi')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('field_keterangan')),
      'Iuran Kas Anggota',
    );
    await tester.enterText(
      find.byKey(const Key('field_nominal')),
      '500000',
    );
    await tester.tap(find.byKey(const Key('btn_simpan')));
    await tester.pumpAndSettle();

    // Verifikasi transaksi pertama muncul dan saldo menjadi Rp 500.000
    expect(find.text('Iuran Kas Anggota'), findsOneWidget);
    final saldoSetelahMasuk = tester.widget<Text>(find.byKey(const Key('text_saldo')));
    expect(saldoSetelahMasuk.data, 'Rp 500.000');

    // 2. Tambah Transaksi Kedua: Pengeluaran Rp 150.000
    await tester.tap(find.byKey(const Key('fab_tambah_transaksi')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('field_keterangan')),
      'Beli Perlengkapan Rapat',
    );
    await tester.enterText(
      find.byKey(const Key('field_nominal')),
      '150000',
    );

    // Ubah jenis transaksi menjadi Pengeluaran
    await tester.tap(find.byKey(const Key('dropdown_jenis')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('item_pengeluaran')).last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('btn_simpan')));
    await tester.pumpAndSettle();

    // 3. Verifikasi kedua transaksi tampil dan saldo akhir menjadi Rp 350.000
    expect(find.text('Iuran Kas Anggota'), findsOneWidget);
    expect(find.text('Beli Perlengkapan Rapat'), findsOneWidget);

    final saldoAkhir = tester.widget<Text>(find.byKey(const Key('text_saldo')));
    expect(saldoAkhir.data, 'Rp 350.000');
  });
}