import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PengaturanPage(),
  ));
}

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Pengaturan",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),

      // Bagian body
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.refresh_sharp),
              color: Colors.blue[900],
              onPressed: () {},
            ),
          ),
          const Divider(thickness: 1),

          // List Printer
          Expanded(
            child: ListView(
              children: [
                _printerItem("85948594589458"),
                _printerItem("69486946849864"),
              ],
            ),
          ),
        ],
      ),

      // Bagian bottomNavigationBar pindah ke sini
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

  // Widget untuk item printer
  Widget _printerItem(String idPrinter) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.print, color: Colors.white),
      ),
      title: const Text("Printer"),
      subtitle: Text(idPrinter),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          // logika sambungkan ke printer
        },
        child: const Text(
          "Sambungkan",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
