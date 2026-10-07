import 'package:flutter/material.dart';

// Data Diri
const String nama = 'Imam Abdurohman Ramdani';
const String nim = '20240040112';
const String prodiKelas = 'Teknik Informatika / TI24G';

class LatihanSesi2Page extends StatelessWidget {
  const LatihanSesi2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      appBar: AppBar(
        elevation: 2,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.tealAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'PPM Sesi 2 - Dashboard Interaktif',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            // 1. Promo Banner Rame
            PromoBanner(),
            SizedBox(height: 16),

            // 2. Quick Stats Row
            QuickStatsRow(),
            SizedBox(height: 16),

            // 3. Profile Card Modern
            ProfileCard(
              nama: nama,
              nim: nim,
              prodiKelas: prodiKelas,
            ),
            SizedBox(height: 16),

            // 4. Counter Card Leveling Interaktif
            CounterCard(),
          ],
        ),
      ),
    );
  }
}

/// 1. Banner Promo dengan Hiasan Melayang & Tombol Aksis
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          // Background Gradient Container
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00695C), Color(0xFF009688), Color(0xFF4DB6AC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          // Hiasan Ikon Transparan Belakang
          Positioned(
            right: -15,
            bottom: -20,
            child: Icon(
              Icons.stars_rounded,
              size: 140,
              color: Colors.white.withOpacity(0.18),
            ),
          ),
          Positioned(
            right: 80,
            top: -10,
            child: Icon(
              Icons.card_giftcard_rounded,
              size: 70,
              color: Colors.white.withOpacity(0.12),
            ),
          ),
          // Teks Banner
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '🔥 SPESIAL SESI 2',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Diskon 50% Akses Fitur Pro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Khusus Mahasiswa Teknik Informatika',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          // Badge Diskon Pojok Kanan
          Positioned(
            right: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 4),
                ],
              ),
              child: const Text(
                '-50% OFF',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 2. Baris Statistik Singkat Mahasiswa
class QuickStatsRow extends StatelessWidget {
  const QuickStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            icon: Icons.school_rounded,
            label: 'Prodi',
            value: 'TI24G',
            color: Colors.teal,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem(
            icon: Icons.star_rounded,
            label: 'IPK Target',
            value: '4.00',
            color: Colors.amber.shade700,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem(
            icon: Icons.verified_user_rounded,
            label: 'Status',
            value: 'Aktif',
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

/// 3. Kartu Profil Mahasiswa Lengkap dengan Badge Skill & Rating
class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodiKelas;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodiKelas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Avatar dengan Indikator Online (Titik Hijau)
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.teal, width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 34,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 31,
                          backgroundImage: AssetImage('assets/Pp.jpeg'),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade400,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              nama,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified,
                            color: Colors.blueAccent,
                            size: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'NIM: $nim',
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      Text(
                        prodiKelas,
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      // Rating Bintang 5
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (_) => const Icon(Icons.star_rounded,
                                color: Colors.amber, size: 18),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '5.0',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            // Chip Badges
            Wrap(
              spacing: 8,
              children: [
                _buildChip('Flutter Dev', Colors.blue.shade50, Colors.blue),
                _buildChip('TI24G', Colors.teal.shade50, Colors.teal),
                _buildChip('Mahasiswa Aktif', Colors.orange.shade50, Colors.orange.shade800),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: text,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// 4. Counter Card Interaktif dengan Progress Bar & Leveling
class CounterCard extends StatefulWidget {
  const CounterCard({super.key});

  @override
  State<CounterCard> createState() => _CounterCardState();
}

class _CounterCardState extends State<CounterCard> {
  int counter = 0;

  void ubahCounter(int val) {
    setState(() {
      counter += val;
      if (counter < 0) counter = 0; // Proteksi agar tidak minus
    });
  }

  void reset() {
    setState(() => counter = 0);
  }

  // Dapatkan Status Level berdasarkan jumlah Counter
  Map<String, dynamic> getLevelStatus() {
    if (counter == 0) {
      return {'title': 'Mulai Hitung 🌱', 'color': Colors.grey};
    } else if (counter < 5) {
      return {'title': 'Level Pemula 🎯', 'color': Colors.teal};
    } else if (counter < 15) {
      return {'title': 'Level Menengah ⚡', 'color': Colors.orange};
    } else {
      return {'title': 'Level Master 🔥', 'color': Colors.redAccent};
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = getLevelStatus();
    final double progress = (counter / 20).clamp(0.0, 1.0);

    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Counter Interaktif',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (status['color'] as Color).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status['title'],
                    style: TextStyle(
                      color: status['color'],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Indikator Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                color: status['color'],
              ),
            ),
            const SizedBox(height: 20),

            // Angka Counter Utama
            Text(
              '$counter',
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: status['color'],
              ),
            ),
            const SizedBox(height: 20),

            // Baris Tombol Aksi: -10, -1, Reset, +1, +10
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => ubahCounter(-10),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('-10'),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () => ubahCounter(-1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100,
                      foregroundColor: Colors.red,
                    ),
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    onPressed: reset,
                    icon: const Icon(Icons.refresh),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () => ubahCounter(1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade100,
                      foregroundColor: Colors.teal,
                    ),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () => ubahCounter(10),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade50,
                      foregroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('+10'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}