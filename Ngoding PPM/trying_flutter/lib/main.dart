import 'package:flutter/material.dart';
import 'sesi_1.dart'; // Import Tugas Sesi 1
import 'sesi_2.dart'; // Import Tugas Sesi 2
import 'latihan_sesi2.dart'; // Import Latihan Sesi 2

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Tugas Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      home: const DashboardScreen(),
    );
  }
}

// ----------------------------------------------------
// HALAMAN UTAMA (DASHBOARD)
// ----------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilPage(),
                ),
              );
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/Pp.jpeg'),
              ),
            ),
          ),
        ),
        title: const Text(
          'My Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Selamat Datang
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.indigo, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Program Perangkat Mobile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dosen Pengampu: Bapak Nugraha, M.Kom.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

// ===================================================
// Daftar Tugas dan Latihan Sesi
// ===================================================

// ---------------------------------
// 📌 SEKSI 1: DAFTAR TUGAS SESI
// ---------------------------------
            const Text(
              '📌 Tugas Utama Sesi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 12),

            _buildMenuCard(
              title: 'Tugas Sesi 1',
              subtitle: 'Aplikasi Counter (Genap/Ganjil)',
              icon: Icons.assignment_rounded,
              color: Colors.indigo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TugasSesi1Page(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            _buildMenuCard(
              title: 'Tugas Sesi 2',
              subtitle: 'Online Shop Profile & Product',
              icon: Icons.assignment_rounded,
              color: Colors.indigo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TugasSesi2Page(),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

// ---------------------------------
// 💻 SEKSI 2: DAFTAR LATIHAN SESI
// ---------------------------------
            const Text(
              '💻 Latihan Praktik Sesi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 12),

            _buildMenuCard(
              title: 'Latihan Sesi 2',
              subtitle: 'Counter Leveling & Interaktif',
              icon: Icons.code_rounded,
              color: Colors.deepOrange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LatihanSesi2Page(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: color.withOpacity(0.12),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// HALAMAN PROFIL MAHASISWA
// ----------------------------------------------------
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