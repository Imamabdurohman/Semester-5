import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/barang_toko_repository.dart';
import '../../data/repositories/tugas_stok_repository.dart';
import '../../domain/models/barang_toko.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      barangRepository: context.read<BarangTokoRepository>(),
      tugasRepository: context.read<TugasStokRepository>(),
    );
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Toko Grosir'),
        actions: [
          IconButton(
            tooltip: 'Muat Ulang',
            onPressed: () => _viewModel.load(forceRefresh: true),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_viewModel.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_viewModel.error!, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _viewModel.load,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final restockList = _viewModel.barangPerluRestock;
          final tugasAktif = _viewModel.tugasBelumSelesai;
          final barangKategori = _viewModel.barangPerKategori;

          return RefreshIndicator(
            onRefresh: () => _viewModel.load(forceRefresh: true),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Ringkasan Kasir Hari Berjalan
                Card(
                  color: colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Omzet Kasir Hari Ini',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formatRupiah(_viewModel.totalOmzetHariIni),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Untung Bersih Hari Ini',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formatRupiah(_viewModel.totalUntungHariIni),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade800,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Peringatan Stok Menipis / Habis + Nomor Sales
                if (restockList.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.error),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: colorScheme.error,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Peringatan Stok Menipis / Habis (${restockList.length} Barang)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onErrorContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...restockList.map(
                          (barang) => Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone_in_talk,
                                  size: 16,
                                  color: colorScheme.onErrorContainer,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    '${barang.nama} (Sisa: ${barang.totalStok}${barang.satuan}) — Hubungi ${barang.namaSales}:${barang.noTelpSales}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: colorScheme.onErrorContainer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                ],

                // Bagian Data Aksi Belum Selesai
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tugas Gudang Belum Selesai (${tugasAktif.length})',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (tugasAktif.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Semua tugas stok dan kulakan sudah beres!'),
                    ),
                  )
                else
                  ...tugasAktif.map(
                    (tugas) => Card(
                      child: CheckboxListTile(
                        value: tugas.isSelesai,
                        onChanged: (_) => _viewModel.toggleTugas(tugas.id),
                        title: Text(
                          tugas.judul,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          tugas.kontakSales != null
                              ? '${tugas.keterangan}\nKontak:${tugas.kontakSales}'
                              : tugas.keterangan,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 18),

                // Bagian Data Utama (Kategori Terpilih)
                Text(
                  'Stok Barang Kategori Terpilih',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _viewModel.daftarKategori.map((kategori) {
                      final selected = _viewModel.kategoriTerpilih == kategori;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(kategori),
                          selected: selected,
                          onSelected: (_) => _viewModel.pilihKategori(kategori),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                ...barangKategori.map(
                  (barang) => Card(
                    child: ListTile(
                      title: Text(
                        barang.nama,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Gudang: ${barang.stokGudang} | Etalase: ${barang.stokEtalase}${barang.satuan}\nSales: ${barang.namaSales} (${barang.noTelpSales})',
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatRupiah(barang.hargaJual),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Terjual: ${barang.terjualHariIni}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}