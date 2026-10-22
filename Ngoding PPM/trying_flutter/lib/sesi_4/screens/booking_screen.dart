import 'package:flutter/material.dart';
import '../models/tour_package.dart';

class BookingScreen extends StatefulWidget {
  final TourPackage package;

  const BookingScreen({super.key, required this.package});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _countController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Poin 5: Menerapkan PopScope untuk konfirmasi saat tombol Back ditekan
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;

        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Batalkan Pemesanan?'),
            content: const Text(
              'Apakah Anda yakin ingin keluar? Data yang Anda isi akan hilang.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Ya, Batalkan', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );

        if (shouldPop == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Form Booking - ${widget.package.title}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap Pemesan',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Nama wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _countController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Peserta (Orang)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.group_outlined),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Jumlah peserta wajib diisi'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Keberangkatan',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dateController.text =
                            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      });
                    }
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Tanggal keberangkatan wajib diisi'
                      : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Poin 4: Menggunakan Navigator.pop() mengembalikan data pemesanan
                      Navigator.pop(context, {
                        'nama': _nameController.text,
                        'jumlah': _countController.text,
                        'tanggal': _dateController.text,
                      });
                    }
                  },
                  child: const Text(
                    'Konfirmasi Pemesanan 🚀',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}