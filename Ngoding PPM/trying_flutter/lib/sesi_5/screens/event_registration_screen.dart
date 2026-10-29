import 'package:flutter/material.dart';
import '../models/event_item.dart';
import '../models/registration_ticket.dart';

class EventRegistrationScreen extends StatefulWidget {
  final EventItem event;

  const EventRegistrationScreen({super.key, required this.event});

  @override
  State<EventRegistrationScreen> createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();

  String _participantType = 'Mahasiswa'; // Mahasiswa, Dosen, Umum
  String _attendanceDate = '';
  String _seminarKit = 'Standard Kit'; // Standard Kit, VIP Kit, Eco Kit
  double _donation = 0.0;
  bool _agreedTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (_attendanceDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Harap pilih tanggal kehadiran!'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    if (!_agreedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Anda harus menyetujui tata tertib seminar!'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulasi loading pendaftaran
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    final ticket = RegistrationTicket(
      id: 'TKT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      eventId: widget.event.id,
      eventTitle: widget.event.title,
      participantName: _nameController.text.trim(),
      nim: _nimController.text.trim(),
      email: _emailController.text.trim(),
      whatsapp: _whatsappController.text.trim(),
      participantType: _participantType,
      attendanceDate: _attendanceDate,
      seminarKit: _seminarKit,
      donation: _donation,
      agreedTerms: _agreedTerms,
      registeredAt: DateTime.now(),
    );

    setState(() => _isLoading = false);

    Navigator.pop(context, ticket);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendaftaran - ${widget.event.title}'),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Memproses tiket pendaftaran Anda...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Informasi Singkat Event
                    Card(
                      color: Colors.indigo.withOpacity(0.08),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            const Icon(Icons.event_seat,
                                color: Colors.indigo, size: 30),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.event.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Pembicara: ${widget.event.speaker}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      '📋 Data Peserta',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    // Input Nama
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Nama wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 12),

                    // Input NIM / Identitas
                    TextFormField(
                      controller: _nimController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'NIM / No. Identitas *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'NIM / No Identitas wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 12),

                    // Input Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Aktif *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Email wajib diisi';
                        }
                        if (!v.contains('@')) return 'Format email tidak valid';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Input WhatsApp
                    TextFormField(
                      controller: _whatsappController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Nomor WhatsApp *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_android_outlined),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Nomor WhatsApp wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 20),

                    // Tipe Peserta (Dropdown)
                    const Text(
                      '🎓 Tipe Peserta',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: _participantType,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.school_outlined),
                      ),
                      items: ['Mahasiswa', 'Dosen / Peneliti', 'Masyarakat Umum']
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _participantType = val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Date Picker Kehadiran
                    const Text(
                      '📅 Tanggal Kehadiran',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(const Duration(days: 1)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 90)),
                        );
                        if (picked != null) {
                          setState(() {
                            _attendanceDate =
                                '${picked.day}-${picked.month}-${picked.year}';
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          _attendanceDate.isEmpty
                              ? 'Pilih Tanggal Kehadiran...'
                              : _attendanceDate,
                          style: TextStyle(
                            color: _attendanceDate.isEmpty ? Colors.grey : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Paket Seminar Kit (Radio List)
                    const Text(
                      '🎁 Pilihan Paket Seminar Kit',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: ['Standard Kit (Gratis)', 'VIP Kit (+Rp 25.000)', 'Eco-Friendly Kit']
                          .map((kit) => RadioListTile<String>(
                                title: Text(kit, style: const TextStyle(fontSize: 13)),
                                value: kit,
                                groupValue: _seminarKit,
                                onChanged: (val) {
                                  if (val != null) setState(() => _seminarKit = val);
                                },
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 12),

                    // Donasi Pengembangan Komunitas
                    const Text(
                      '❤️ Donasi Komunitas (Opsional)',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Slider(
                      value: _donation,
                      min: 0,
                      max: 50000,
                      divisions: 10,
                      label: 'Rp ${_donation.toInt()}',
                      onChanged: (val) => setState(() => _donation = val),
                    ),
                    Text(
                      'Jumlah Donasi: Rp ${_donation.toInt()}',
                      style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Persetujuan Tata Tertib (Checkbox)
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _agreedTerms,
                      title: const Text(
                        'Saya menyetujui seluruh tata tertib dan ketentuan acara NusaEvent Hub.',
                        style: TextStyle(fontSize: 12),
                      ),
                      onChanged: (val) => setState(() => _agreedTerms = val ?? false),
                    ),
                    const SizedBox(height: 24),

                    // Tombol Submit Form
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _submitForm,
                        child: const Text(
                          'Selesaikan Pendaftaran 🚀',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
