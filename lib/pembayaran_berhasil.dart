import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TransferBerhasilPage(
        nominal: 'IDR 100,000.00',
        tanggal: '29 Juli 2025 12:00',
        namaPenerima: 'Afria Reva',
      ),
    );
  }
}

class TransferBerhasilPage extends StatelessWidget {
  final String nominal;
  final String tanggal;
  final String namaPenerima;

  const TransferBerhasilPage({
    super.key,
    required this.nominal,
    required this.tanggal,
    required this.namaPenerima,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E40AF),
        title: const Text(
          "AppDef",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Ubah dari center ke start
                children: [
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white, // Isi lingkaran putih
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF1E40AF), // Pinggir biru
                          width: 4,
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Color(0xFF1E40AF), // Centang biru
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'TRANSFER BERHASIL',
                              style: TextStyle(
                                color: Color(0xFF1E40AF),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Overpass',
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              nominal,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'DETAIL TRANSAKSI :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E40AF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InfoRow(label: 'Tanggal Transaksi', value: tanggal),
                  const InfoRow(
                      label: 'No. BCA Virtual Account',
                      value: '451651151519009840'),
                  InfoRow(label: 'Nama Penerima', value: namaPenerima),
                  const InfoRow(label: 'Dari Rekening', value: '624651005561692268'),
                  InfoRow(label: 'Nominal Bayar', value: nominal),
                  const InfoRow(label: 'Total Bayar', value: 'IDR 100,000.00'),
                  const InfoRow(
                      label: 'Kode Referal', value: 'TBK745-SDBF74-51RJK2-AAH2'),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E40AF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Implement print or other action
                      },
                      child: const Text(
                        "CETAK",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF1E40AF),
            child: const Text(
              "© Appdef 2729",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Overpass',
              fontWeight: FontWeight.w600,
              color: Colors.black, // Ubah dari Color(0xFF1E40AF) ke Colors.black
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Overpass',
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
