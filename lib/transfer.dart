// transfer.dart
import 'package:aplikasibca/pembayaran_berhasil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransferPage extends StatefulWidget {
  final int saldo;
  const TransferPage({Key? key, required this.saldo}) : super(key: key);

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController rekeningController = TextEditingController();
  final TextEditingController penerimaController = TextEditingController();
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController beritaController = TextEditingController();

  @override
  void dispose() {
    rekeningController.dispose();
    penerimaController.dispose();
    nominalController.dispose();
    beritaController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.close, color: Colors.red),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      ),
    );
  }

  void _onKirimPressed() {
    final jumlahTransfer = int.tryParse(nominalController.text) ?? 0;

    if (jumlahTransfer <= 0) {
      _showErrorDialog('Nominal tidak valid', 'Masukkan nominal transfer yang benar.');
      return;
    }

    if (jumlahTransfer > widget.saldo) {
      _showErrorDialog('Gagal Transfer', 'Saldo tidak cukup untuk melakukan transfer.');
      return;
    }

    // Format nominal & tanggal untuk struk
    final formatter = NumberFormat('#,##0', 'id');
    final nominalFormatted = formatter.format(jumlahTransfer);
    final tanggalFormatted = DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now());

    // Lanjut ke halaman struk, lalu kembalikan jumlah transfer ke HomePage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransferBerhasilPage(
          nominal: nominalFormatted,
          tanggal: tanggalFormatted,
          namaPenerima: penerimaController.text,
          catatan: beritaController.text,
        ),
      ),
    ).then((_) {
      Navigator.pop(context, jumlahTransfer); // kirim balik ke HomePage supaya saldo dikurangi
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            backgroundColor: const Color(0xFF1E4C92),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text("Transfer", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Profile
            const Row(
              children: [
                CircleAvatar(radius: 24, backgroundColor: Colors.grey, child: Icon(Icons.person, color: Colors.white)),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jane Doe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF385696))),
                    Text("69486946849864", style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Rekening Tujuan
            const Text("Rekening Tujuan", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF385696))),
            const SizedBox(height: 6),
            TextField(
              controller: rekeningController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                hintText: "Masukkan Rekening Tujuan",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),

            // Penerima
            const Text("Penerima", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF385696))),
            const SizedBox(height: 6),
            TextField(
              controller: penerimaController,
              decoration: InputDecoration(
                hintText: "Masukkan Nama Penerima",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),

            // Nominal
            const Text("Nominal", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF385696))),
            TextField(
              keyboardType: TextInputType.number,
              controller: nominalController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // hanya angka
              decoration: const InputDecoration(hintText: "Masukkan Nominal"),
            ),
            const SizedBox(height: 16),

            // Catatan
            const Text("Catatan", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF385696))),
            TextField(
              controller: beritaController,
              decoration: const InputDecoration(hintText: "Masukkan Catatan"),
            ),
            const SizedBox(height: 16),

            // Jenis Transfer (placeholder)
            const Text("Jenis Transfer", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF385696))),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E4C92),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: const Text("Sekarang", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E4C92),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: _onKirimPressed,
                child: const Text("Kirim", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Footer
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          height: 50,
          color: const Color(0xFF1E4C92),
          alignment: Alignment.center,
          child: const Text("© Appdef 2729", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
