import 'package:flutter/material.dart';

class TambahSaldoPage extends StatefulWidget {
  const TambahSaldoPage({super.key});
  @override
  State<TambahSaldoPage> createState() => _TambahSaldoPageState();
}

class _TambahSaldoPageState extends State<TambahSaldoPage> {
  final TextEditingController _controller = TextEditingController();
  String? metodePembayaran;

  int? _selectedNominal; // ✅ simpan tombol yang dipilih

  void _pilihCepat(int nominal) {
    setState(() {
      _controller.text = nominal.toString();
      _selectedNominal = nominal; // tandai nominal yang dipilih
    });
  }

  @override
  void initState() {
    super.initState();
    // ✅ kalau user ngetik manual, reset pilihan cepat
    _controller.addListener(() {
      final input = int.tryParse(_controller.text);
      if (input != _selectedNominal) {
        setState(() {
          _selectedNominal = null; // reset pilihan cepat
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E4C92),
        title:
            const Text("Tambah Saldo", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nominal", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Masukkan Nominal",
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text("Pilihan Cepat",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                _quickButton("Rp10.000", 10000),
                const SizedBox(width: 8),
                _quickButton("Rp50.000", 50000),
                const SizedBox(width: 8),
                _quickButton("Rp100.000", 100000),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Metode Pembayaran",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
              ),
              hint: const Text("Pilih Metode Pembayaran"),
              items: const [
                DropdownMenuItem(value: "Cash", child: Text("Cash")),
                DropdownMenuItem(
                    value: "Transfer Bank", child: Text("Transfer Bank")),
                DropdownMenuItem(value: "E-Wallet", child: Text("E-Wallet")),
              ],
              onChanged: (value) => metodePembayaran = value,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3C88),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  final input = int.tryParse(_controller.text);
                  if (input != null && input > 0) {
                    Navigator.pop(context, input); // ✅ bisa manual & cepat
                  }
                },
                child: const Text("Tambah Saldo",
                    style: TextStyle(color: Colors.white)),
              ),
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

  Widget _quickButton(String label, int nominal) {
    final bool isSelected = _selectedNominal == nominal; // ✅ cek apakah dipilih

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF1E3C88) : Colors.white,
        side: const BorderSide(color: Color(0xFF1E3C88)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => _pilihCepat(nominal),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF1E3C88),
        ),
      ),
    );
  }
}
