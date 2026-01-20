import 'package:flutter/material.dart';
import 'order_list_page.dart';

class SellerDashboardPage extends StatelessWidget {
  const SellerDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Penjual')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OrderListPage()),
            );
          },
          child: const Text('Lihat Pesanan'),
        ),
      ),
    );
  }
}
