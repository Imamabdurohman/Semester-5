import 'package:flutter/material.dart';
import '../models/tour_package.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Poin 4: Minimal 4 paket wisata
  List<TourPackage> get _tourPackages => [
        TourPackage(
          id: 'p1',
          title: 'Wisata Candi Borobudur',
          description:
              'Nikmati keindahan mahakarya sejarah dan keajaiban dunia di Magelang.',
          price: 350000,
          imageUrl: 'https://picsum.photos/id/1015/400/250',
        ),
        TourPackage(
          id: 'p2',
          title: 'Eksotika Pantai Kuta Bali',
          description:
              'Rasakan hangatnya pasir putih dan keindahan matahari terbenam Pulau Dewata.',
          price: 850000,
          imageUrl: 'https://picsum.photos/id/1016/400/250',
        ),
        TourPackage(
          id: 'p3',
          title: 'Petualangan Gunung Bromo',
          description:
              'Menikmati matahari terbit dan lautan pasir yang menakjubkan di Bromo.',
          price: 600000,
          imageUrl: 'https://picsum.photos/id/1018/400/250',
        ),
        TourPackage(
          id: 'p4',
          title: 'Taman Nasional Raja Ampat',
          description:
              'Surga bawah laut kelas dunia dengan gugusan pulau karang mempesona.',
          price: 2500000,
          imageUrl: 'https://picsum.photos/id/1019/400/250',
        ),
      ];

  String _formatRupiah(double number) {
    return 'Rp ${number.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaTravel - Destinasi'),
        actions: [
          // Poin 4 & 7: Tombol Logout menggunakan pushNamedAndRemoveUntil()
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.splash,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _tourPackages.length,
        itemBuilder: (context, index) {
          final package = _tourPackages[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // Poin 4: Menggunakan pushNamed() dan arguments
                Navigator.pushNamed(
                  context,
                  AppRoutes.detail,
                  arguments: package,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      package.imageUrl,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 160,
                        color: Colors.indigo.shade100,
                        child: const Icon(Icons.landscape, size: 50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          package.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatRupiah(package.price),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),
                            const Row(
                              children: [
                                Text('Detail ', style: TextStyle(fontSize: 12)),
                                Icon(Icons.arrow_forward_ios, size: 12),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}