import 'package:flutter/material.dart';
import '../../database/order_db.dart';
import '../../models/order_model.dart';
import 'order_detail_page.dart';

class UserOrderListPage extends StatelessWidget {
  const UserOrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan Saya')),
      body: FutureBuilder<List<OrderModel>>(
        future: OrderDB().getAllOrders(), // sementara semua order
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return const Center(child: Text('Belum ada pesanan'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, i) {
              final o = orders[i];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Pesanan #${o.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${o.statusOrder}'),
                      Text('Total: Rp ${o.total}'),
                      Text('${o.tanggal} ${o.jam}'),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserOrderDetailPage(order: o),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
