import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/repositories/barang_toko_repository.dart';
import '../data/repositories/rekap_harian_repository.dart';
import '../data/repositories/tugas_stok_repository.dart';
import '../data/services/kasir_gudang_service.dart';

List<SingleChildWidget> get appProviders {
  return [
    Provider<KasirGudangService>(
      create: (_) => const KasirGudangService(),
    ),
    ChangeNotifierProvider<BarangTokoRepository>(
      create: (context) => BarangTokoRepository(
        context.read<KasirGudangService>(),
      ),
    ),
    ChangeNotifierProvider<TugasStokRepository>(
      create: (context) => TugasStokRepository(
        context.read<KasirGudangService>(),
      ),
    ),
    ChangeNotifierProvider<RekapHarianRepository>(
      create: (context) => RekapHarianRepository(
        context.read<KasirGudangService>(),
      ),
    ),
  ];
}