import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/tugas_stok_repository.dart';
import '../../checklist_stok/checklist_stok_screen.dart';
import '../../home/home_screen.dart';
import '../../kasir_rekap/kasir_rekap_screen.dart';
import '../../stok_barang/stok_barang_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    StokBarangScreen(),
    ChecklistStokScreen(),
    KasirRekapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final tugasRepository = context.read<TugasStokRepository>();

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: tugasRepository,
        builder: (context, _) {
          final jumlahBelumSelesai = tugasRepository.jumlahBelumSelesai;

          return NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront),
                label: 'Beranda',
              ),
              const NavigationDestination(
                icon: Icon(Icons.inventory_2_outlined),
                selectedIcon: Icon(Icons.inventory_2),
                label: 'Stok',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: jumlahBelumSelesai > 0,
                  label: Text('$jumlahBelumSelesai'),
                  child: const Icon(Icons.checklist_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: jumlahBelumSelesai > 0,
                  label: Text('$jumlahBelumSelesai'),
                  child: const Icon(Icons.checklist),
                ),
                label: 'Checklist',
              ),
              const NavigationDestination(
                icon: Icon(Icons.point_of_sale_outlined),
                selectedIcon: Icon(Icons.point_of_sale),
                label: 'Kasir & Rekap',
              ),
            ],
          );
        },
      ),
    );
  }
}