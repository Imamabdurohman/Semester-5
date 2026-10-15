import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import Provider & Screen Sesi 3
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/catalog_screen.dart';

// Import File Sesi & Latihan Lainnya
import 'sesi_1.dart'; 
import 'sesi_2.dart'; 
import 'latihan_sesi2.dart'; 
import 'latihan_sesi3.dart'; 
import 'profil_page.dart'; // Import file profil yang sudah dipisah

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Konfigurasi Utama Aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Tugas Flutter',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: const DashboardScreen(),
    );
  }
}

// Halaman Utama (Dashboard)
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        // Tombol Shortcut ke Halaman Profil di Kiri Atas
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
            // 📌 KOMPONEN 1: Banner Informasi Mata Kuliah
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

            // 📌 KOMPONEN 2: Daftar Sesi / Menu Navigasi Tugas & Latihan
            const Text(
              'Tugas Utama Sesi',
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
                  MaterialPageRoute(builder: (context) => const TugasSesi1Page()),
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
                  MaterialPageRoute(builder: (context) => const TugasSesi2Page()),
                );
              },
            ),
            const SizedBox(height: 10),

            _buildMenuCard(
              title: 'Tugas Sesi 3',
              subtitle: 'NusaBookstore State Management (Provider)',
              icon: Icons.assignment_rounded,
              color: Colors.indigo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogScreen()),
                );
              },
            ),

            const SizedBox(height: 25),

            const Text(
              'Latihan Praktik Sesi',
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
                  MaterialPageRoute(builder: (context) => const LatihanSesi2Page()),
                );
              },
            ),
            const SizedBox(height: 10),

            _buildMenuCard(
              title: 'Latihan Sesi 3',
              subtitle: 'Latihan State Management',
              icon: Icons.code_rounded,
              color: Colors.deepOrange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LatihanSesi3Page()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pendukung untuk Membuat Kartu Menu
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
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
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