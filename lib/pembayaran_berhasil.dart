import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
    transferData = widget.data;
  }

  // ✅ Fungsi untuk format tanggal & nominal
  String formatRupiah(int nominal) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(nominal);
  }

  String formatTanggal(DateTime tanggal) {
    return DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(tanggal);
  }

  // ✅ Fungsi untuk cetak PDF (struk)
  Future<void> cetakStruk() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'Bukti Transfer',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Tanggal: ${formatTanggal(transferData.tanggal)}'),
                pw.Text('Nama Penerima: ${transferData.namaPenerima}'),
                pw.Text('Rekening Tujuan: ${transferData.rekeningTujuan}'),
                pw.Text('Nominal: ${formatRupiah(transferData.nominal)}'),
                if (transferData.catatan.isNotEmpty)
                  pw.Text('Catatan: ${transferData.catatan}'),
                pw.Divider(),
                pw.Center(
                  child: pw.Text('Terima kasih telah menggunakan layanan kami'),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1F5BA3),
        title: const Text(
          "Transfer Berhasil",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 15),
            const Text(
              "Transfer Berhasil!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Card detail modern
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              shadowColor: Colors.black26,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("Nama Penerima", transferData.namaPenerima),
                    _buildRow("Rekening Tujuan", transferData.rekeningTujuan),
                    _buildRow("Nominal", formatRupiah(transferData.nominal)),
                    if (transferData.catatan.isNotEmpty)
                      _buildRow("Catatan", transferData.catatan),
                    _buildRow("Tanggal", formatTanggal(transferData.tanggal)),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // ✅ Tombol Aksi (Print & Kembali)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.print, color: Colors.white),
                  label: const Text("Print Struk",
                      style: TextStyle(color: Colors.white)),
                  onPressed: cetakStruk,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.home, color: Colors.white),
                  label: const Text("Kembali",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context, {
                      'namaPenerima': transferData.namaPenerima,
                      'nominal': transferData.nominal,
                      'tanggal': formatTanggal(transferData.tanggal),
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F5BA3),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
