import 'package:flutter/material.dart';
import '../models/tour_package.dart';
import 'booking_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  String _formatRupiah(double number) {
    return 'Rp ${number.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    // Poin 4: Menerima arguments dari ModalRoute
    final package = ModalRoute.of(context)!.settings.arguments as TourPackage;

    return Scaffold(
      appBar: AppBar(
        title: Text(package.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              package.imageUrl,
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 240,
                color: Colors.indigo.shade100,
                child: const Icon(Icons.landscape, size: 80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatRupiah(package.price),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const Divider(height: 30),
                  const Text(
                    'Deskripsi Paket:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    package.description,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            // Poin 4 & 6: Menggunakan await Navigator.push() dan menampilkan SnackBar
            final bookingData = await Navigator.push<Map<String, dynamic>>(
              context,
              MaterialPageRoute(
                builder: (context) => BookingScreen(package: package),
              ),
            );

            if (bookingData != null && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '✅ Booking Berhasil!\nNama: ${bookingData['nama']} (${bookingData['jumlah']} Orang) - Tgl: ${bookingData['tanggal']}',
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 4),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: const Text(
            'Pesan Sekarang 🎟️',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}