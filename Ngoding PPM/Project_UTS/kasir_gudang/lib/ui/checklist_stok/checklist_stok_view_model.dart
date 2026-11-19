import 'package:flutter/foundation.dart';
import '../../data/repositories/tugas_stok_repository.dart';
import '../../domain/models/tugas_stok.dart';

class ChecklistStokViewModel extends ChangeNotifier {
  final TugasStokRepository _tugasRepository;

  bool _isLoading = false;
  String? _error;
  List<TugasStok> _semuaTugas = [];

  ChecklistStokViewModel({
    required TugasStokRepository tugasRepository,
  }) : _tugasRepository = tugasRepository {
    _tugasRepository.addListener(_onTugasChanged);
  }

  bool get isLoading => _isLoading;
  String? get error => _error;

  List<TugasStok> get tugasBelumSelesai =>
      _semuaTugas.where((t) => !t.isSelesai).toList();

  List<TugasStok> get tugasSelesai =>
      _semuaTugas.where((t) => t.isSelesai).toList();

  Future<void> load({bool forceRefresh = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _semuaTugas =
          await _tugasRepository.getAllTugas(forceRefresh: forceRefresh);
    } catch (e) {
      _error = 'Gagal memuat daftar checklist: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleTugas(String id) {
    _tugasRepository.toggleSelesai(id);
  }

  void _onTugasChanged() {
    _semuaTugas = _tugasRepository.items;
    notifyListeners();
  }

  @override
  void dispose() {
    _tugasRepository.removeListener(_onTugasChanged);
    super.dispose();
  }
}