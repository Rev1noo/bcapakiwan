import 'package:flutter/material.dart';

class AktifitasPage extends StatelessWidget {
  const AktifitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E40AF), // biru tua
        iconTheme:
            const IconThemeData(color: Colors.white), // tombol kembali putih
        title: const Text(
          "Aktifitas",
          style: TextStyle(
            color: Colors.white, // warna putih pada tulisan
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Jul",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1, // Bagian kiri lebih kecil
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("24",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.left),
                      SizedBox(height: 8),
                      Text("Juli",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.left),
                      SizedBox(height: 8),
                      Text("2025",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
                const SizedBox(width: 50), // Jarak antara kiri dan kanan
                Expanded(
                  flex: 7, // Bagian kanan lebih besar
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Bintang Ramadhani",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.left),
                      SizedBox(height: 8),
                      Text("IDR. 1.000.000",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.left),
                      SizedBox(height: 8),
                      Text("Berhasil",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
