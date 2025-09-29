import 'package:flutter/material.dart';

class AktifitasPage extends StatefulWidget {
  final List<Map<String, String>> transaksiList;

  const AktifitasPage({super.key, required this.transaksiList});

  @override
  State<AktifitasPage> createState() => _AktifitasPageState();
}

class _AktifitasPageState extends State<AktifitasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E40AF),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Aktifitas",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: widget.transaksiList.isEmpty
          ? const Center(
              child: Text("Belum ada aktifitas",
                  style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
              itemCount: widget.transaksiList.length,
              itemBuilder: (context, index) {
                final data = widget.transaksiList[index];
                final pecahTanggal = data["tanggal"]!.split(" ");
                String hari = pecahTanggal[0];
                String bulan = pecahTanggal[1];
                String tahun = pecahTanggal[2];

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(hari, style: const TextStyle(fontSize: 20)),
                            Text(bulan, style: const TextStyle(fontSize: 16)),
                            Text(tahun, style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data["judul"] != null)
                              Text(data["judul"]!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            if (data["namaPenerima"] != null)
                              Text(data["namaPenerima"]!,
                                  style: const TextStyle(fontSize: 16)),
                            Text(data["nominal"]!,
                                style: const TextStyle(fontSize: 16)),
                            Text(
                              data["status"]!,
                              style: TextStyle(
                                fontSize: 16,
                                color: data["status"] == "Berhasil"
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
