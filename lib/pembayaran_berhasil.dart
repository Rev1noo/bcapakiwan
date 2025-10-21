import 'package:flutter/material.dart';

// ✅ Data transfer dikirim dari halaman Transfer
class TransferData {
  final String rekeningTujuan;
  final String namaPenerima;
  final int nominal;
  final String catatan;
  final DateTime tanggal;

  TransferData({
    required this.rekeningTujuan,
    required this.namaPenerima,
    required this.nominal,
    required this.catatan,
    required this.tanggal,
  });
}

// ✅ Halaman Transfer Berhasil (Stateful)
class HalamanTransferBerhasil extends StatefulWidget {
  final TransferData data;

  const HalamanTransferBerhasil({super.key, required this.data});

  @override
  State<HalamanTransferBerhasil> createState() =>
      _HalamanTransferBerhasilState();
}

class _HalamanTransferBerhasilState extends State<HalamanTransferBerhasil> {
  late TransferData transferData;

  @override
  void initState() {
    super.initState();
    transferData = widget.data; // inisialisasi data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // supaya tidak ada tombol back default
        backgroundColor: const Color(0xFF1F5BA3),
        title: const Text(
          "Transfer Berhasil",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Transfer Berhasil!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // ✅ Detail transaksi
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("Rekening Tujuan", transferData.rekeningTujuan),
                    _buildRow("Nama Penerima", transferData.namaPenerima),
                    _buildRow("Nominal", "Rp ${transferData.nominal}"),
                    if (transferData.catatan.isNotEmpty)
                      _buildRow("Catatan", transferData.catatan),
                    _buildRow("Tanggal", "${transferData.tanggal}"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ✅ Tombol kembali ke halaman utama
            ElevatedButton(
              onPressed: () {
                // kirim balik nominal ke halaman sebelumnya
                Navigator.pop(context, transferData);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F5BA3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Kembali ke Beranda",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ widget untuk menampilkan detail
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 16, color: Colors.black54)),
          Text(value,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
