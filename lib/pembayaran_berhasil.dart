import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Model data transfer
class TransferData {
  final String rekeningTujuan;
  final String namaPenerima;
  final int nominal;
  final String catatan;
  final String dariRekening;
  final String virtualAccount;
  final String kodeReferal;
  final DateTime tanggal;

  TransferData({
    required this.rekeningTujuan,
    required this.namaPenerima,
    required this.nominal,
    required this.catatan,
    required this.dariRekening,
    required this.virtualAccount,
    required this.kodeReferal,
    required this.tanggal,
  });
}

class HalamanTransferBerhasil extends StatelessWidget {
  final TransferData data;

  const HalamanTransferBerhasil({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 2);
    final dateFormat = DateFormat('d MMMM yyyy HH:mm', 'id_ID');

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5BA3),
        title: const Text('AppDef'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 18),
            // Icon ceklis
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: const Center(
                child: Icon(Icons.check, size: 70, color: Color(0xFF1F5BA3)),
              ),
            ),
            const SizedBox(height: 18),

            // Card putih
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Text('TRANSFER BERHASIL',
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(
                    currency.format(data.nominal),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('DETAIL TRANSAKSI :',
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 8),

                  _infoBar('Tanggal Transaksi', dateFormat.format(data.tanggal)),
                  _infoBar('No. Virtual Account', data.virtualAccount),
                  _infoBar('Nama Penerima', data.namaPenerima),
                  _infoBar('Dari Rekening', data.dariRekening),
                  _infoBar('Nominal Bayar', currency.format(data.nominal)),
                  _infoBar('Total Bayar', currency.format(data.nominal)),
                  if (data.catatan.isNotEmpty) _infoBar('Catatan', data.catatan),
                  _infoBar('Kode Referal', data.kodeReferal),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Tombol Cetak
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fungsi cetak belum dibuat')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F5BA3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('CETAK'),
              ),
            ),

            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1F5BA3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '© Appdef 2729',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  Widget _infoBar(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 150, child: Text(judul, style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600))),
          Expanded(child: Text(isi, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
