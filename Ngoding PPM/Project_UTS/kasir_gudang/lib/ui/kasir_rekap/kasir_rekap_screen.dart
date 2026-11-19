import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/barang_toko_repository.dart';
import '../../data/repositories/rekap_harian_repository.dart';
import '../../data/repositories/tugas_stok_repository.dart';
import '../../domain/models/barang_toko.dart';
import 'kasir_rekap_view_model.dart';

class KasirRekapScreen extends StatefulWidget {
  const KasirRekapScreen({super.key});

  @override
  State<KasirRekapScreen> createState() => _KasirRekapScreenState();
}

class _KasirRekapScreenState extends State<KasirRekapScreen> {
  late final KasirRekapViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = KasirRekapViewModel(
      barangRepository: context.read<BarangTokoRepository>(),
      rekapRepository: context.read<RekapHarianRepository>(),
      tugasRepository: context.read<TugasStokRepository>(),
    );
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _bukaDialogKasirKeluar() async {
    final barangList = _viewModel.daftarBarang;
    if (barangList.isEmpty) return;

    String selectedId = barangList.first.id;
    final jumlahController = TextEditingController(text: '1');

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          final selectedBarang =
              barangList.firstWhere((b) => b.id == selectedId);
          return AlertDialog(
            title: const Text('Catat Penjualan Kasir'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Pilih Barang',
                    border: OutlineInputBorder(),
                  ),
                  items: barangList
                      .map(
                        (b) => DropdownMenuItem(
                          value: b.id,
                          child: Text(
                            '${b.nama} (Etalase: ${b.stokEtalase})',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setStateDialog(() => selectedId = val);
                    }
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  'Harga Jual: ${formatRupiah(selectedBarang.hargaJual)} | Modal: ${formatRupiah(selectedBarang.hargaBeli)}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Terjual',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              FilledButton(
                onPressed: () {
                  final jumlah = int.tryParse(jumlahController.text) ?? 0;
                  final errorMsg = _viewModel.catatTransaksiKasir(
                    barangId: selectedId,
                    jumlahJual: jumlah,
                  );
                  Navigator.pop(context);
                  if (mounted) {
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        content: Text(
                          errorMsg ??
                              'Penjualan dicatat! Stok etalase & laba otomatis diperbarui.',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Simpan Transaksi'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _bukaDialogBarangMasukGudang() async {
    final barangList = _viewModel.daftarBarang;
    if (barangList.isEmpty) return;

    String selectedId = barangList.first.id;
    final jumlahController = TextEditingController(text: '5');
    final hargaBeliController = TextEditingController(
      text: barangList.first.hargaBeli.toString(),
    );

    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text('Input Barang Datang ke Gudang'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: selectedId,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Pilih Barang Datang',
                      border: OutlineInputBorder(),
                    ),
                    items: barangList
                        .map(
                          (b) => DropdownMenuItem(
                            value: b.id,
                            child: Text(
                              '${b.nama} (Gudang: ${b.stokGudang})',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        final item =
                            barangList.firstWhere((b) => b.id == val);
                        setStateDialog(() {
                          selectedId = val;
                          hargaBeliController.text = item.hargaBeli.toString();
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Masuk ke Gudang',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: hargaBeliController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Harga Beli Modal Satuan (Rp)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              FilledButton(
                onPressed: () {
                  final jumlah = int.tryParse(jumlahController.text) ?? 0;
                  final hargaBeli =
                      int.tryParse(hargaBeliController.text) ?? 0;
                  if (jumlah > 0) {
                    _viewModel.inputBarangMasukGudang(
                      barangId: selectedId,
                      jumlahMasuk: jumlah,
                      hargaBeliBaru: hargaBeli,
                    );
                  }
                  Navigator.pop(context);
                  if (mounted && jumlah > 0) {
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Barang berhasil ditambahkan ke gudang beserta harga modalnya.',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Masuk Gudang'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _prosesTutupToko() {
    final berhasil = _viewModel.tutupTokoDanRekap();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          berhasil
              ? 'Toko ditutup! Seluruh transaksi hari ini otomatis direkap ke riwayat.'
              : 'Belum ada transaksi terjual hari ini untuk direkap.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir, Laba & Tutup Toko'),
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_viewModel.error != null) {
            return Center(child: Text(_viewModel.error!));
          }

          final terjualList = _viewModel.barangTerjualHariIni;
          final riwayat = _viewModel.riwayatRekap;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Tombol Aksi Cepat Pemilik & Kasir
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _bukaDialogKasirKeluar,
                      icon: const Icon(Icons.shopping_cart_checkout),
                      label: const Text('Kasir Jual'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: _bukaDialogBarangMasukGudang,
                      icon: const Icon(Icons.add_business),
                      label: const Text('Barang Masuk'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Kartu Rincian Keuangan Hari Berjalan
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Perhitungan Otomatis Kasir (Hari Ini)',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      _BarisKeuangan(
                        label: 'Total Barang Terjual',
                        nilai: '${_viewModel.totalItemTerjualHariIni} Unit/Dus',
                      ),
                      _BarisKeuangan(
                        label: 'Total Uang Masuk (Omzet)',
                        nilai: formatRupiah(_viewModel.totalOmzetHariIni),
                      ),
                      _BarisKeuangan(
                        label: 'Modal yang Kembali',
                        nilai:
                            formatRupiah(_viewModel.totalModalKembaliHariIni),
                      ),
                      _BarisKeuangan(
                        label: 'Keuntungan Bersih',
                        nilai: formatRupiah(_viewModel.totalUntungHariIni),
                        warnaNilai: Colors.green.shade800,
                        tebal: true,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.indigo,
                          ),
                          onPressed: _prosesTutupToko,
                          icon: const Icon(Icons.lock_clock),
                          label: const Text('Tutup Toko & Rekap Otomatis'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Rincian Per Barang yang Terjual Hari Ini
              Text(
                'Rincian Laba Per Barang (Hari Ini)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              if (terjualList.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Belum ada transaksi baru sejak tutup toko terakhir.',
                    ),
                  ),
                )
              else
                ...terjualList.map(
                  (b) => Card(
                    child: ListTile(
                      title: Text(
                        '${b.nama} (${b.terjualHariIni} ${b.satuan})',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Uang Masuk: ${formatRupiah(b.omzetHariIni)} | Modal Kembali: ${formatRupiah(b.modalKembaliHariIni)}',
                      ),
                      trailing: Text(
                        '+${formatRupiah(b.untungHariIni)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Riwayat Rekap Otomatis Tutup Toko (Data Informasi)
              Text(
                'Arsip Rekap Otomatis Tutup Toko (${riwayat.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ...riwayat.map(
                (rekap) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              rekap.tanggal,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Untung: ${formatRupiah(rekap.totalUntungBersih)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Terjual: ${rekap.totalItemTerjual} unit | Omzet: ${formatRupiah(rekap.totalUangMasuk)} | Modal: ${formatRupiah(rekap.totalModalKembali)}',
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Detail: ${rekap.ringkasanBarang}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BarisKeuangan extends StatelessWidget {
  final String label;
  final String nilai;
  final Color? warnaNilai;
  final bool tebal;

  const _BarisKeuangan({
    required this.label,
    required this.nilai,
    this.warnaNilai,
    this.tebal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            nilai,
            style: TextStyle(
              fontWeight: tebal ? FontWeight.bold : FontWeight.w600,
              color: warnaNilai,
            ),
          ),
        ],
      ),
    );
  }
}