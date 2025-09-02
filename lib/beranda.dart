import 'package:aplikasibca/informarsi.dart';
import 'package:aplikasibca/pengaturan.dart';
import 'package:aplikasibca/transfer.dart';
import 'package:flutter/material.dart';
import 'aktifitas.dart'; // Tambahkan ini

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1E40AF), // biru tua
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul + icon setting & notifikasi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "AppDef",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.settings,
                                  color: Colors.white),
                              onPressed: () {
                                // Aksi ketika tombol pengaturan ditekan
                              },
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              icon: const Icon(Icons.notifications,
                                  color: Colors.white),
                              onPressed: () {
                                // Aksi ketika tombol lonceng ditekan
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Halo, Ananda Irvan Revino Putra",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 12),

                    // Card saldo
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16), // Margin di semua sisi
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Rekening: 123 - 456 - 7890",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Saldo Aktif",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "IDR 150.000.000",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Menu Utama
            const Text(
              "Menu Utama",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  menuItem(
                    Icons.camera_alt,
                    "Aktifitas",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const AktifitasPage(), // <-- panggil class widget
                        ),
                      );
                    },
                  ),
                  menuItem(Icons.compare_arrows, "Transfer", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TransferPage(),
                      ),
                    );
                  }),
                  menuItem(Icons.payment, "Pembayaran", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AktifitasPage()),
                    );
                  }),
                  menuItem(Icons.info_outline, "Informasi", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const InformasiPage()),
                    );
                  }),
                  menuItem(Icons.settings, "Pengaturan", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PengaturanPage()),
                    );
                  }),
                  menuItem(Icons.more_horiz, "Lainnya", null),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            height: 50,
            color: const Color(0xFF1E4C92),
            alignment: Alignment.center,
            child: const Text(
              "© Appdef 2729",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }

  Widget menuItem(IconData icon, String title, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, size: 28, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
