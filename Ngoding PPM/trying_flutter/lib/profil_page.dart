import 'package:flutter/material.dart';

// 📌 KOMPONEN 3: Halaman Profil Mahasiswa
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Foto Profil & Nama
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 52,
                      backgroundImage: AssetImage('assets/Pp.jpeg'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Imam Abdurohman Ramdani',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Program Perangkat Mobile',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Kartu Informasi Akademik & Kontak
            Card(
              elevation: 2,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    _buildInfoTile(
                      icon: Icons.badge_outlined,
                      label: 'NIM',
                      value: '20240040112',
                    ),
                    const Divider(indent: 20, endIndent: 20, height: 1),
                    _buildInfoTile(
                      icon: Icons.school_outlined,
                      label: 'Semester',
                      value: 'Semester 5',
                    ),
                    const Divider(indent: 20, endIndent: 20, height: 1),
                    _buildInfoTile(
                      icon: Icons.class_outlined,
                      label: 'Kelas',
                      value: 'TI24G',
                    ),
                    const Divider(indent: 20, endIndent: 20, height: 1),
                    _buildInfoTile(
                      icon: Icons.school_outlined,
                      label: 'Program Studi',
                      value: 'Teknik Informatika',
                    ),
                    const Divider(indent: 20, endIndent: 20, height: 1),
                    _buildInfoTile(
                      icon: Icons.phone_android_outlined,
                      label: 'No HP',
                      value: '0838-0604-5240',
                    ),
                    const Divider(indent: 20, endIndent: 20, height: 1),
                    _buildInfoTile(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: 'imam.abdurohman_ti24@nusaputra.ac.id',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pendukung untuk Baris Detail Informasi
  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.indigo.withOpacity(0.1),
        child: Icon(icon, color: Colors.indigo, size: 20),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}