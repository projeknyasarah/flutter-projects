import 'package:flutter/material.dart';
import 'order_status_page.dart';

class QRISPage extends StatelessWidget {
  final int orderId;

  const QRISPage({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran QRIS'),
        automaticallyImplyLeading: false, // ⬅️ biar gak balik ke form
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code, size: 120),
            const SizedBox(height: 16),
            const Text(
              'Silakan lakukan pembayaran',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderStatusPage(
                        orderId: orderId, // ⬅️ KUNCI UTAMA
                      ),
                    ),
                  );
                },
                child: const Text('Lihat Status Pesanan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
