import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  List<BluetoothDevice> perangkatDitemukan = [];
  bool sedangScan = false;
  BluetoothDevice? perangkatTersambung;

  @override
  void initState() {
    super.initState();
    // Tidak langsung scan, scan hanya ketika tombol ditekan
    _mintaIzin(); 
  }

  // 🧩 Minta izin Bluetooth & lokasi
  Future<void> _mintaIzin() async {
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();
  }

  // 🔍 Scan perangkat Bluetooth di sekitar
  Future<void> _scanPerangkat() async {
    if (sedangScan) return;

    setState(() {
      perangkatDitemukan.clear();
      sedangScan = true;
    });

    try {
      // Mulai scan
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      // Dengarkan hasil scan
      FlutterBluePlus.scanResults.listen((results) {
        if (!mounted) return;
        for (ScanResult r in results) {
          if (!perangkatDitemukan.contains(r.device)) {
            setState(() {
              perangkatDitemukan.add(r.device);
            });
          }
        }
      });

      // Hentikan scan otomatis setelah 5 detik
      await Future.delayed(const Duration(seconds: 5));
      await FlutterBluePlus.stopScan();
    } catch (e) {
      print('Error scan: $e');
    }

    if (mounted) {
      setState(() {
        sedangScan = false;
      });
    }
  }

  // 🔌 Sambungkan ke perangkat
  Future<void> _sambungkan(BluetoothDevice device) async {
    try {
      await device.connect(
        autoConnect: false,
        timeout: const Duration(seconds: 10),
      );

      if (!mounted) return;

      setState(() {
        perangkatTersambung = device;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil tersambung ke ${device.platformName}'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyambungkan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Bluetooth')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: sedangScan ? null : _scanPerangkat,
              child: Text(sedangScan ? 'Memindai...' : 'Scan Perangkat'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: perangkatDitemukan.length,
              itemBuilder: (context, index) {
                final device = perangkatDitemukan[index];
                return ListTile(
                  title: Text(device.platformName.isNotEmpty
                      ? device.platformName
                      : 'Perangkat Tanpa Nama'),
                  subtitle: Text(device.remoteId.str),
                  trailing: ElevatedButton(
                    onPressed: () => _sambungkan(device),
                    child: const Text('Sambungkan'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
