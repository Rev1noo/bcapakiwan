import 'package:flutter/material.dart';

class AktifitasPage extends StatelessWidget {
  final List<Map<String, dynamic>> transaksiList;

  const AktifitasPage({super.key, required this.transaksiList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E40AF),
        title: const Text("Riwayat Aktifitas"),
      ),
      body: transaksiList.isEmpty
          ? const Center(
              child: Text("Belum ada transaksi"),
            )
          : ListView.builder(
              itemCount: transaksiList.length,
              itemBuilder: (context, index) {
                final transaksi = transaksiList[index];
                return ListTile(
                  leading: const Icon(Icons.swap_horiz,
                      color: Color(0xFF1E40AF)),
                  title: Text(transaksi["judul"] ?? ""),
                  subtitle: Text(
                      "${transaksi["namaPenerima"]} • ${transaksi["tanggal"]}"),
                  trailing: Text(
                    transaksi["nominal"] ?? "",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
