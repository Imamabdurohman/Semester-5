import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/barang_toko_repository.dart';
import '../../domain/models/barang_toko.dart';
import 'stok_barang_view_model.dart';

class StokBarangScreen extends StatefulWidget {
  const StokBarangScreen({super.key});

  @override
  State<StokBarangScreen> createState() => _StokBarangScreenState();
}

class _StokBarangScreenState extends State<StokBarangScreen> {
  late final StokBarangViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = StokBarangViewModel(
      barangRepository: context.read<BarangTokoRepository>(),
    );
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _tampilkanDialogPindahEtalase(BarangToko barang) async {
    final controller = TextEditingController(text: '1');
    final hasil = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pindah ke Etalase\n${barang.nama}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stok tersedia di gudang: ${barang.stokGudang} ${barang.satuan}'),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah dipindah ke etalase',
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
              final jumlah = int.tryParse(controller.text) ?? 0;
              Navigator.pop(context, jumlah);
            },
            child: const Text('Pindahkan'),
          ),
        ],
      ),
    );

    if (hasil != null && mounted) {
      final sukses = _viewModel.pindahKeEtalase(barang.id, hasil);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            sukses
                ? 'Berhasil memindahkan $hasil ${barang.satuan} ke etalase.'
                : 'Jumlah melebihi stok di gudang!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stok Gudang & Etalase'),
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

          final listBarang = _viewModel.barangTersaring;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                child: SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<String>(
                    showSelectedIcon: false,
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      textStyle: WidgetStateProperty.all(
                        const TextStyle(fontSize: 12),
                      ),
                    ),
                    segments: const [
                      ButtonSegment(value: 'Sembako', label: Text('Sembako')),
                      ButtonSegment(value: 'Minuman', label: Text('Minuman')),
                      ButtonSegment(
                        value: 'Makanan Ringan',
                        label: Text('Makanan'),
                      ),
                      ButtonSegment(
                        value: 'Kebutuhan Rumah',
                        label: Text('Rumah'),
                      ),
                    ],
                    selected: {_viewModel.kategoriDipilih},
                    onSelectionChanged: (newSelection) {
                      _viewModel.ubahKategori(newSelection.first);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: listBarang.length,
                  itemBuilder: (context, index) {
                    final barang = listBarang[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    barang.nama,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (barang.perluRestock)
                                  Chip(
                                    label: Text(
                                      barang.isStokHabis
                                          ? 'STOK HABIS'
                                          : 'STOK MENIPIS',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    backgroundColor: Colors.red.shade700,
                                    padding: EdgeInsets.zero,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Harga Modal: ${formatRupiah(barang.hargaBeli)}  |  Harga Jual: ${formatRupiah(barang.hargaJual)}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _BadgeStok(
                                    label: 'Gudang',
                                    nilai: '${barang.stokGudang} ${barang.satuan}',
                                    warna: Colors.blueGrey.shade100,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _BadgeStok(
                                    label: 'Etalase',
                                    nilai: '${barang.stokEtalase} ${barang.satuan}',
                                    warna: Colors.teal.shade100,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _BadgeStok(
                                    label: 'Terjual',
                                    nilai: '${barang.terjualHariIni} ${barang.satuan}',
                                    warna: Colors.amber.shade100,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Sales: ${barang.namaSales}\nTelp: ${barang.noTelpSales}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                OutlinedButton.icon(
                                  onPressed: barang.stokGudang > 0
                                      ? () => _tampilkanDialogPindahEtalase(barang)
                                      : null,
                                  icon: const Icon(Icons.move_down, size: 18),
                                  label: const Text('Ke Etalase'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BadgeStok extends StatelessWidget {
  final String label;
  final String nilai;
  final Color warna;

  const _BadgeStok({
    required this.label,
    required this.nilai,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11)),
          Text(
            nilai,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}