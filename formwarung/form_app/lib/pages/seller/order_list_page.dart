import 'package:flutter/material.dart';
import '../../database/order_db.dart';
import '../../models/order_model.dart';
import 'order_detail_page.dart';

class OrderListPage extends StatelessWidget {
  OrderListPage({super.key});

  final OrderDB _orderDB = OrderDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pesanan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: _orderDB.getAllOrders(),
        builder: (context, snapshot) {
          /* ===================== LOADING ===================== */
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /* ===================== ERROR ===================== */
          if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi error: ${snapshot.error}'),
            );
          }

          /* ===================== EMPTY ===================== */
          final orders = snapshot.data ?? [];
          if (orders.isEmpty) {
            return const Center(child: Text('Belum ada pesanan'));
          }

          /* ===================== LIST ===================== */
          return ListView.separated(
            itemCount: orders.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final o = orders[i];

              return ListTile(
                title: Text(
                  o.namaPemesan,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total: Rp ${o.total}'),
                    Text('${o.tanggal} • ${o.jam}'),
                    if (o.catatan != null && o.catatan!.isNotEmpty)
                      const Text(
                        'Ada catatan pembeli',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailPage(order: o),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
