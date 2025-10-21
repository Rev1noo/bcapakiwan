import 'package:aplikasibca/pembayaran_berhasil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransferPage extends StatefulWidget {
  final int saldoAwal;

  const TransferPage({super.key, required this.saldoAwal});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  late int saldo;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController rekeningController = TextEditingController();
  final TextEditingController namaPenerimaController = TextEditingController();
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    saldo = widget.saldoAwal;
  }

  @override
  void dispose() {
    rekeningController.dispose();
    namaPenerimaController.dispose();
    nominalController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  void _kirim() async {
    if (_formKey.currentState!.validate()) {
      final nominal = int.parse(nominalController.text);

      if (nominal > saldo) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Saldo tidak mencukupi!")),
        );
        return;
      }

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HalamanTransferBerhasil(
            data: TransferData(
              rekeningTujuan: rekeningController.text,
              namaPenerima: namaPenerimaController.text,
              nominal: nominal,
              catatan: catatanController.text,
              tanggal: DateTime.now(),
            ),
          ),
        ),
      );
      if (result != null) {
        setState(() {
          saldo -= nominal;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5BA3),
        title: const Text('Transfer', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Saldo saat ini: Rp $saldo"),
              const SizedBox(height: 10),
              TextFormField(
                controller: rekeningController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(7),
                ],
                decoration: const InputDecoration(
                  labelText: 'Rekening Tujuan (7 angka)',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Wajib diisi';
                  if (v.length != 7) return 'Harus 7 angka';
                  return null;
                },
              ),
              TextFormField(
                controller: namaPenerimaController,
                decoration: const InputDecoration(labelText: 'Nama Penerima'),
                validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: nominalController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Nominal'),
                validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: catatanController,
                decoration:
                    const InputDecoration(labelText: 'Catatan (opsional)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _kirim,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F5BA3),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Kirim"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
