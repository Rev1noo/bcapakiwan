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
      home: InformasiPage(),
    );
  }
}

class InformasiPage extends StatelessWidget {
  const InformasiPage({super.key});

  final List<String> anggota = const [
    "Devina Ratasya Salsabila",
    "Gracia Destyan Cleo Violeta",
    "Bintang Ramadhani",
    "Ananda Irvan Revino",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 AppBar dengan corner radius bawah
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              "Informasi",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Kelompok",
            style: TextStyle(
              fontFamily: 'Overpass',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF1E40AF),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: anggota
                  .map(
                    (nama) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      child: Text(
                        nama,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Overpass',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1E40AF),
                        ),
                      ),
                    ),
                  )
                  .toList(),
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
          height: 50, // kasih tinggi biar ga nutup full screen
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
}
