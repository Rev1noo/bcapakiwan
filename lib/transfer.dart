import 'package:flutter/material.dart';

void main() {
  runApp(const transfer());
}

class transfer extends StatelessWidget {
  const transfer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TransferPage(),
    );
  }
}

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              "Transfer",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Profile
            const Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jane Doe",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF385696))),
                    Text("69486946849864",
                        style: TextStyle(color: Colors.black54)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),

            // Rekening Tujuan
            const Text(
              "Rekening Tujuan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF385696),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: rekeningController,
              decoration: InputDecoration(
                hintText: "Masukkan Rekening Tujuan",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),

            // Penerima
            const Text("Penerima",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF385696))),
            const SizedBox(height: 6),
            TextField(
              controller: penerimaController,
              decoration: InputDecoration(
                hintText: "Masukkan Nama Penerima",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),

            // Nominal
            const Text("Nominal",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF385696))),
            TextField(
              keyboardType: TextInputType.number,
              controller: nominalController,
              decoration: const InputDecoration(
                hintText: "Masukkan Nominal",
              ),
            ),
            const SizedBox(height: 16),

            // Berita
            const Text("Berita",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF385696))),
            TextField(
              controller: beritaController,
              decoration: const InputDecoration(
                hintText: "Masukkan Berita",
              ),
            ),
            const SizedBox(height: 16),

            // Jenis Transfer
            const Text("Jenis Transfer",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF385696))),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E4C92),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: const Text(
                  "Sekarang",
                  style: TextStyle(color: Colors.white),
                ),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {},
                child: const Text(
                  "Kirim",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Footer mirip AppBar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1E4C92),
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              margin: const EdgeInsets.only(bottom: 0),
              child: const Center(
                child: Text(
                "© Appdef 2729",
                style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
