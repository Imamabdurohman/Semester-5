import 'package:flutter/material.dart';
import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';

class TambahTransaksiScreen extends StatefulWidget {
  final KasViewModel viewModel;

  const TambahTransaksiScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<TambahTransaksiScreen> createState() => _TambahTransaksiScreenState();
}

class _TambahTransaksiScreenState extends State<TambahTransaksiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _keteranganController = TextEditingController();
  final _nominalController = TextEditingController();

  JenisTransaksi _selectedJenis = JenisTransaksi.pemasukan;
  DateTime _selectedTanggal = DateTime.now();
  String? _validationError;

  @override
  void dispose() {
    _keteranganController.dispose();
    _nominalController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedTanggal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        _selectedTanggal = picked;
      });
    }
  }

  void _simpanTransaksi() {
    setState(() {
      _validationError = null;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nominal = double.tryParse(_nominalController.text.trim()) ?? 0.0;
    final berhasil = widget.viewModel.tambahTransaksi(
      keterangan: _keteranganController.text,
      nominal: nominal,
      jenis: _selectedJenis,
      tanggal: _selectedTanggal,
    );

    if (berhasil) {
      Navigator.pop(context, true);
    } else {
      setState(() {
        _validationError = widget.viewModel.errorMessage;
      });
    }
  }

  String _formatTanggal(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi Kas'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info saldo saat ini
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Saldo Kas Tersedia:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Rp ${widget.viewModel.saldo.toInt()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Kolom 1: Keterangan
              TextFormField(
                key: const Key('field_keterangan'),
                controller: _keteranganController,
                decoration: const InputDecoration(
                  labelText: 'Keterangan Transaksi *',
                  hintText: 'Contoh: Iuran Kas Anggota',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Keterangan wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Kolom 2: Nominal
              TextFormField(
                key: const Key('field_nominal'),
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nominal (Rp) *',
                  hintText: 'Contoh: 50000',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nominal wajib diisi';
                  }
                  final parsed = double.tryParse(value.trim());
                  if (parsed == null) {
                    return 'Nominal harus berupa angka yang valid';
                  }
                  if (parsed <= 0) {
                    return 'Nominal harus lebih dari nol';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Kolom 3: Jenis Transaksi
              DropdownButtonFormField<JenisTransaksi>(
                key: const Key('dropdown_jenis'),
                value: _selectedJenis,
                decoration: const InputDecoration(
                  labelText: 'Jenis Transaksi *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.swap_vert_rounded),
                ),
                items: const [
                  DropdownMenuItem(
                    key: Key('item_pemasukan'),
                    value: JenisTransaksi.pemasukan,
                    child: Text('Pemasukan'),
                  ),
                  DropdownMenuItem(
                    key: Key('item_pengeluaran'),
                    value: JenisTransaksi.pengeluaran,
                    child: Text('Pengeluaran'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedJenis = value;
                      _validationError = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Kolom 4: Tanggal Transaksi
              InkWell(
                key: const Key('field_tanggal'),
                onTap: _pilihTanggal,
                borderRadius: BorderRadius.circular(4),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Transaksi',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  child: Text(_formatTanggal(_selectedTanggal)),
                ),
              ),
              const SizedBox(height: 16),

              // Pesan Error Aturan Bisnis (misal: Pengeluaran > Saldo)
              if (_validationError != null)
                Container(
                  key: const Key('text_error_saldo'),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.redAccent),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _validationError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 8),

              // Tombol Simpan
              ElevatedButton.icon(
                key: const Key('btn_simpan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _simpanTransaksi,
                icon: const Icon(Icons.save_rounded),
                label: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}