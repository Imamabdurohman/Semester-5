import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/tugas_stok_repository.dart';
import 'checklist_stok_view_model.dart';

class ChecklistStokScreen extends StatefulWidget {
  const ChecklistStokScreen({super.key});

  @override
  State<ChecklistStokScreen> createState() => _ChecklistStokScreenState();
}

class _ChecklistStokScreenState extends State<ChecklistStokScreen> {
  late final ChecklistStokViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ChecklistStokViewModel(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist Gudang & Restock'),
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

          final belumSelesai = _viewModel.tugasBelumSelesai;
          final sudahSelesai = _viewModel.tugasSelesai;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Perlu Dikerjakan (${belumSelesai.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              if (belumSelesai.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Tidak ada tugas tertunda.'),
                  ),
                )
              else
                ...belumSelesai.map(
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
                            ? '[${tugas.jenisTugas}] ${tugas.keterangan}\nKontak: ${tugas.kontakSales}'
                            : '[${tugas.jenisTugas}] ${tugas.keterangan}',
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                'Selesai (${sudahSelesai.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
              ),
              const SizedBox(height: 8),
              if (sudahSelesai.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Belum ada tugas yang selesai.'),
                  ),
                )
              else
                ...sudahSelesai.map(
                  (tugas) => Card(
                    color: Colors.grey.shade100,
                    child: CheckboxListTile(
                      value: tugas.isSelesai,
                      onChanged: (_) => _viewModel.toggleTugas(tugas.id),
                      title: Text(
                        tugas.judul,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      subtitle: Text(tugas.keterangan),
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