import 'package:flutter/material.dart';

class TugasSesi1Page extends StatefulWidget {
  const TugasSesi1Page({super.key});

  @override
  State<TugasSesi1Page> createState() => _TugasSesi1PageState();
}

class _TugasSesi1PageState extends State<TugasSesi1Page> {
  int _counter = 0;

  // Fungsi penambah counter (+)
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Fungsi pengurang counter (-) dengan proteksi tidak boleh di bawah 0
  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    } else {
      // Tampilkan SnackBar jika ditekan saat angka 0
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Counter tidak boleh di bawah 0!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // Fungsi reset counter ke 0
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pengecekan genap atau ganjil
    bool isEven = _counter % 2 == 0;
    // Perubahan warna angka (Indigo untuk Genap, DeepOrange untuk Ganjil)
    Color numberColor = isEven ? Colors.indigo : Colors.deepOrange;
    String statusText = isEven ? 'Angka Genap' : 'Angka Ganjil';

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          'Tugas Sesi 1',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // ===============
            // KARTU MAHASISWA
            // ===============
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // FOTO PROFIL DENGAN BINGKAI HITAM
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.black, // BINGKAI HITAM
                    child: CircleAvatar(
                      radius: 29,
                      backgroundImage: AssetImage('assets/Pp.jpeg'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Imam Abdurohman Ramdani',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'NIM: 20240040112',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Teknik Informatika / TI24G',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),

            // ===================================================
            // AREA COUNTER & UTILITY
            // ===================================================
            Card(
              elevation: 2,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    // Badge Status Teks
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: numberColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: numberColor.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: numberColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Tampilan Angka Counter
                    Text(
                      '$_counter',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: numberColor,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Baris Tombol +, Reset, dan -
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tombol (-)
                        ElevatedButton(
                          onPressed: _decrementCounter,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(18),
                            backgroundColor: Colors.red.shade50,
                            foregroundColor: Colors.red,
                            elevation: 1,
                          ),
                          child: const Icon(Icons.remove, size: 28),
                        ),
                        const SizedBox(width: 12),

                        // Tombol Reset
                        ElevatedButton.icon(
                          onPressed: _resetCounter,
                          icon: const Icon(Icons.refresh, size: 20),
                          label: const Text(
                            'Reset',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.black87,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Tombol (+)
                        ElevatedButton(
                          onPressed: _incrementCounter,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(18),
                            backgroundColor: Colors.indigo.shade50,
                            foregroundColor: Colors.indigo,
                            elevation: 1,
                          ),
                          child: const Icon(Icons.add, size: 28),
                        ),
                      ],
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
}