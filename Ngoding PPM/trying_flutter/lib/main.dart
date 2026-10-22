import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Sesi 4
import 'sesi_4/nusa_travel_app.dart';

// Import Sesi 3
import 'sesi_3/providers/cart_provider.dart';
import 'sesi_3/providers/theme_provider.dart';
import 'sesi_3/screens/catalog_screen.dart';
import 'sesi_3/latihan_sesi3.dart';
import 'sesi_3/bloc/bloc_page.dart';

// Import Sesi 1 & Sesi 2
import 'sesi_1/sesi_1.dart'; 
import 'sesi_2/sesi_2.dart'; 
import 'sesi_2/latihan_sesi2.dart'; 

// Import Profil
import 'profil_page.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Tugas Flutter',
      
      // 1. Hubungkan status tema dari Provider
      themeMode: themeProvider.themeMode,

      // 2. Definisi Tema Terang Global
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
      ),

      // 3. Definisi Tema Gelap Global
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final themeProvider = context.watch<ThemeProvider>();
    // Ganti baris 76:
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
              radius: 19,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/Pp.jpeg'),
              ),
            ),
          ),
        ),
        title: const Text(
          'My Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: isDark ? 'Mode Terang' : 'Mode Gelap',
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? Colors.amber : Colors.indigo,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark 
                      ? [Colors.indigo.shade900, Colors.indigo.shade700]
                      : [Colors.indigo, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
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
                  SizedBox(height: 6),
                  Text(
                    'Dosen Pengampu: Bapak Nugraha, M.Kom.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ======================
            // Tugas & Latihan Sesi
            // ======================
            Text(
              '📌 Tugas Utama Sesi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),

            _buildMenuCard(
              context,
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
              context,
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
              context,
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

            _buildMenuCard(
              context,
              title: 'Tugas Sesi 4',
              subtitle: 'NusaTravel App (Routing & Navigation)',
              icon: Icons.card_travel_rounded,
              color: Colors.indigo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NusaTravelApp()),
                );
              },
            ),
            const SizedBox(height: 24),

            Text(
              '💻 Latihan Praktik Sesi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 12),

            _buildMenuCard(
              context,
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
              context,
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
            const SizedBox(height: 10),

            _buildMenuCard(
              context,
              title: 'Demo BLoC (Sesi 3)',
              subtitle: 'State Management BLoC Pattern',
              icon: Icons.developer_board_rounded,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BlocPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1.5,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withOpacity(0.12),
                child: Icon(icon, color: color, size: 24),
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
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
