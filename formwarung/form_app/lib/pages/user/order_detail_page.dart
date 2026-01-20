import 'package:flutter/material.dart';
import '../../database/order_db.dart';
import '../../models/order_model.dart';

class UserOrderDetailPage extends StatelessWidget {
  final OrderModel order;

  const UserOrderDetailPage({
    super.key,
    required this.order,
  });

  Color _statusColor(String status) {
    switch (status) {
      case 'BARU':
        return Colors.orange;
      case 'DIPROSES':
        return Colors.blue;
      case 'DIANTAR':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pesanan #${order.id}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Chip(
              label: Text(order.statusOrder),
              backgroundColor: _statusColor(order.statusOrder),
              labelStyle: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 16),
            Text('Nama: ${order.namaPemesan}'),
            Text('Tipe: ${order.tipe}'),
            Text('Total: Rp ${order.total}'),
            Text('Tanggal: ${order.tanggal} ${order.jam}'),

            if (order.alamat != null) ...[
              const SizedBox(height: 12),
              const Text('Alamat:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(order.alamat!),
            ],

            if (order.catatan != null && order.catatan!.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text('Catatan:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(order.catatan!),
            ],

            const SizedBox(height: 20),
            const Text(
              'Item Pesanan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: OrderDB().getOrderItems(order.id),
                builder: (context, snapshot) {
                  final items = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final item = items[i];
                      return ListTile(
                        title: Text(item['nama_menu']),
                        subtitle: Text('Jumlah: ${item['jumlah']}'),
                        trailing: Text('Rp ${item['harga']}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
