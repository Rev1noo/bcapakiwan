import 'package:aplikasibca/informarsi.dart';
import 'package:aplikasibca/pengaturan.dart';
import 'package:aplikasibca/saldo.dart';
import 'package:aplikasibca/transfer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'aktifitas.dart';

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
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
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
  int nominal = 2000000;
  List<Map<String, String>> riwayatTransaksi = [];

  String formatRupiah(int number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(number);
  }

  void _tambahSaldo() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TambahSaldoPage()),
    );

    if (hasil != null && hasil is int) {
      setState(() {
        nominal += hasil;
        riwayatTransaksi.insert(0, {
          "judul": "Tambah Saldo",
          "nominal": "+ ${formatRupiah(hasil)}",
          "status": "Berhasil",
          "tanggal": DateFormat('dd MMMM yyyy').format(DateTime.now()),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF007BFF),
        titleSpacing: 16,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Hello, User",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              "3140172323",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          // ---------- Card Saldo ----------
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Saldo Anda",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Icon(Icons.remove_red_eye, color: Colors.grey, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  formatRupiah(nominal),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // ---------- Grid Menu ----------
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                children: [
                  menuItem(Icons.history_rounded, "Aktifitas", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AktifitasPage(transaksiList: riwayatTransaksi),
                      ),
                    );
                  }),
                  menuItem(Icons.swap_horiz_rounded, "Transfer", () async {
                    final hasilTransfer = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TransferPage(saldo: nominal)),
                    );

                    if (hasilTransfer != null && hasilTransfer is int) {
                      setState(() {
                        nominal -= hasilTransfer;
                        riwayatTransaksi.insert(0, {
                          "judul": "Transfer",
                          "namaPenerima": "Gracia",
                          "nominal": "- ${formatRupiah(hasilTransfer)}",
                          "status": "Berhasil",
                          "tanggal": DateFormat('dd MMMM yyyy')
                              .format(DateTime.now()),
                        });
                      });
                    }
                  }),
                  menuItem(Icons.account_balance_wallet, "Tambah Saldo", _tambahSaldo),
                  menuItem(Icons.info_outline_rounded, "Informasi", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const InformasiPage()),
                    );
                  }),
                  menuItem(Icons.settings, "Pengaturan", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PengaturanPage()),
                    );
                  }),
                  menuItem(Icons.more_horiz, "Lainnya", null),
                ],
              ),
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
          height: 55,
          color: const Color(0xFF007BFF),
          alignment: Alignment.center,
          child: const Text(
            "© Appdef 2729",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: const Color(0xFF007BFF)),
          ),
          const SizedBox(height: 8),
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
