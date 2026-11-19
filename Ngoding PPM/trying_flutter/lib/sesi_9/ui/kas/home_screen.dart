import 'package:flutter/material.dart';
import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';
import 'tambah_transaksi_screen.dart';

class HomeScreen extends StatefulWidget {
  final KasViewModel? viewModel;

  const HomeScreen({super.key, this.viewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final KasViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel ?? KasViewModel();
  }

  String _formatRupiah(double number) {
    final isNegative = number < 0;
    final absNumber = number.abs().toInt();
    final formatted = absNumber.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return '${isNegative ? "-" : ""}Rp $formatted';
  }

  String _formatTanggal(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Future<void> _bukaTambahTransaksi() async {
    final hasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => TambahTransaksiScreen(viewModel: _viewModel),
      ),
    );

    if (hasil == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaksi berhasil disimpan!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        final transaksiList = _viewModel.daftarTransaksi;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'NusaKas - Kas Himpunan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              // Ringkasan Saldo, Pemasukan, dan Pengeluaran
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.indigo, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saldo Kas Saat Ini',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatRupiah(_viewModel.saldo),
                      key: const Key('text_saldo'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(color: Colors.white24, height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryItem(
                            icon: Icons.arrow_downward_rounded,
                            iconColor: Colors.greenAccent,
                            label: 'Total Pemasukan',
                            value: _formatRupiah(_viewModel.totalPemasukan),
                            valueKey: const Key('text_total_pemasukan'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSummaryItem(
                            icon: Icons.arrow_upward_rounded,
                            iconColor: Colors.orangeAccent,
                            label: 'Total Pengeluaran',
                            value: _formatRupiah(_viewModel.totalPengeluaran),
                            valueKey: const Key('text_total_pengeluaran'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Header Riwayat Transaksi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Riwayat Transaksi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${transaksiList.length} item',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Daftar Transaksi (ListView + Dismissible)
              Expanded(
                child: transaksiList.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Belum ada transaksi tercatat',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
                        itemCount: transaksiList.length,
                        itemBuilder: (context, index) {
                          final item = transaksiList[index];
                          final isMasuk = item.isPemasukan;

                          return Dismissible(
                            key: Key('dismissible_${item.id}'),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              _viewModel.hapusTransaksi(item.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Transaksi "${item.keterangan}" dihapus',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: isMasuk
                                      ? Colors.green.withOpacity(0.12)
                                      : Colors.red.withOpacity(0.12),
                                  child: Icon(
                                    isMasuk
                                        ? Icons.south_west_rounded
                                        : Icons.north_east_rounded,
                                    color: isMasuk ? Colors.green : Colors.red,
                                  ),
                                ),
                                title: Text(
                                  item.keterangan,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Text(
                                  '${isMasuk ? "Pemasukan" : "Pengeluaran"} • ${_formatTanggal(item.tanggal)}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                trailing: Text(
                                  '${isMasuk ? "+" : "-"} ${_formatRupiah(item.nominal)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: isMasuk ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            key: const Key('fab_tambah_transaksi'),
            onPressed: _bukaTambahTransaksi,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Tambah'),
          ),
        );
      },
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Key valueKey,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  key: valueKey,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}