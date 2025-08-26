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
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text(
          "Pengaturan",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
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

          Container(
            color: Colors.blue[900],
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: const Center(
              child: Text(
                "© Appdef 2729",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

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
          //logika sambungkan ke printer yang tersedia
        },
        child: const Text(
          "Sambungkan",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
