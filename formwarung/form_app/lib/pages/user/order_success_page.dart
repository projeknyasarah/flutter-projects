import 'package:flutter/material.dart';

class OrderSuccessPage extends StatelessWidget {
  final String nama;
  final String tipe;
  final int total;
  final String metodeBayar;

  const OrderSuccessPage({
    super.key,
    required this.nama,
    required this.tipe,
    required this.total,
    required this.metodeBayar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan Berhasil')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              Text('Terima kasih, $nama!', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text('Tipe Pesanan: $tipe', style: const TextStyle(fontSize: 16)),
              Text('Metode Bayar: $metodeBayar', style: const TextStyle(fontSize: 16)),
              Text('Total Bayar: Rp $total', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Kembali ke Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
