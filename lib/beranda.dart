import 'package:aplikasibca/saldo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transfer.dart';
import 'aktifitas.dart';
import 'informarsi.dart';
import 'pengaturan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int saldo = 1000000;
  List<Map<String, dynamic>> riwayatTransaksi = [];

  String formatRupiah(int number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id',
      symbol: 'IDR ',
      decimalDigits: 0,
    );
    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),

          // Nama pengguna & No rekening
          const Text(
            "Jane Doe",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Rekening: 123 - 456 - 7890",
            style: TextStyle(color: Colors.black54),
          ),

          const SizedBox(height: 20),

          // ---------- Kotak Saldo ----------
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E40AF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Saldo Aktif",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  formatRupiah(saldo),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ---------- Menu ----------
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              crossAxisSpacing: 20,
              mainAxisSpacing: 25,
              children: [
                menuItem(Icons.history, "Aktifitas", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AktifitasPage(transaksiList: riwayatTransaksi),
                    ),
                  );
                }),
                menuItem(Icons.swap_horiz, "Transfer", () async {
                  final hasilTransfer = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TransferPage(saldo: saldo),
                    ),
                  );

                  if (hasilTransfer != null && hasilTransfer is Map) {
                    setState(() {
                      saldo -= hasilTransfer["nominal"] as int;
                      riwayatTransaksi.insert(0, {
                        "judul": "Transfer",
                        "namaPenerima": hasilTransfer["penerima"],
                        "nominal":
                            "- ${formatRupiah(hasilTransfer["nominal"])}",
                        "status": "Berhasil",
                        "tanggal":
                            DateFormat('dd MMM yyyy').format(DateTime.now()),
                      });
                    });
                  }
                }),
                menuItem(Icons.payment, "Pembayaran", () async {
                  final hasilTambahSaldo = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TambahSaldoPage()),
                  );

                  if (hasilTambahSaldo != null && hasilTambahSaldo is int) {
                    setState(() {
                      saldo += hasilTambahSaldo; 
                      riwayatTransaksi.insert(0, {
                        "judul": "Tambah Saldo",
                        "namaPenerima": "Top Up",
                        "nominal": "+ ${formatRupiah(hasilTambahSaldo)}",
                        "status": "Berhasil",
                        "tanggal":
                            DateFormat('dd MMM yyyy').format(DateTime.now()),
                      });
                    });
                  }
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
                menuItem(Icons.more_horiz, "Lainnya", () {}),
              ],
            ),
          ),
        ],
      ),

      // ---------- Footer ----------
      bottomNavigationBar: Container(
        height: 50,
        color: const Color(0xFF1E40AF),
        alignment: Alignment.center,
        child: const Text(
          "© Appdef 2729",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget menuItem(IconData icon, String title, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF1E40AF),
            child: Icon(icon, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
