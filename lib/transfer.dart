import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransferPage extends StatefulWidget {
  final int saldo;

  const TransferPage({super.key, required this.saldo});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController rekeningController = TextEditingController();
  final TextEditingController namaPenerimaController = TextEditingController();
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  @override
  void dispose() {
    rekeningController.dispose();
    namaPenerimaController.dispose();
    nominalController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  void _kirim() {
    if (_formKey.currentState!.validate()) {
      final nominal = int.parse(nominalController.text);

      if (nominal > widget.saldo) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Saldo tidak mencukupi!")),
        );
        return;
      }

      Navigator.pop(context, {
        "penerima": namaPenerimaController.text,
        "nominal": nominal,
        "catatan": catatanController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F5BA3),
        title: const Text('Transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                validator: (v) =>
                    v == null || v.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: nominalController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Nominal'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Wajib diisi' : null,
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
