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
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E40AF),
        title: const Text("Informasi", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
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
          const Spacer(),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF1E40AF),
            child: const Text(
              "© Appdef 2729",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
