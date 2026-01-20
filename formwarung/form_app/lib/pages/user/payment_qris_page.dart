import 'package:flutter/material.dart';

class QRISPage extends StatelessWidget {
  const QRISPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bayar QRIS')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Scan QRIS berikut untuk membayar',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Image.asset(
              'assets/qris.png', // pastikan file ini ada di folder assets/
              width: 200,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // selesai bayar → kembali ke dashboard / halaman sukses
                Navigator.pushReplacementNamed(context, '/success');
              },
              child: const Text('Selesai Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
