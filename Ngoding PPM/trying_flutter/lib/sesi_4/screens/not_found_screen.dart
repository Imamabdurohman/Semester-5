import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded, size: 90, color: Colors.orangeAccent),
              const SizedBox(height: 16),
              const Text(
                '404 - Page Not Found',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Maaf, halaman yang Anda cari tidak tersedia.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                child: const Text('Kembali ke Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}