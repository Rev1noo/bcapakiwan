import 'package:flutter/material.dart';

class AktifitasPage extends StatelessWidget {
  const AktifitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aktifitas"),
      ),
      body: const Center(
        child: Text("Halaman Aktifitas"),
      ),
    );
  }
}
