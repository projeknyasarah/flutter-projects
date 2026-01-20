import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../database/order_db.dart';
import '../../models/order_model.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailPage({
    super.key,
    required this.order,
  });

  Future<void> _updateStatus(BuildContext context, String status) async {
    final db = await DBHelper().database;

    await db.update(
      'orders',
      {'status_order': status},
      where: 'id = ?',
      whereArgs: [order.id],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status diubah ke $status')),
    );

    Navigator.pop(context);
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
            _info('Nama', order.namaPemesan),
            _info('Tanggal', order.tanggal),
            _info('Jam', order.jam),
            _info('Tipe', order.tipe),
            _info('Total', 'Rp ${order.total}'),

            if (order.tipe == 'DELIVERY')
              _info('Alamat', order.alamat ?? '-'),

            const SizedBox(height: 12),

            const Text(
              'Catatan Pembeli',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                order.catatan != null && order.catatan!.isNotEmpty
                    ? order.catatan!
                    : '- Tidak ada catatan -',
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Daftar Pesanan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: OrderDB().getOrderItems(order.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final items = snapshot.data!;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final item = items[i];
                      return ListTile(
                        title: Text(item['nama_menu'] ?? '-'),
                        subtitle: Text('Qty: ${item['jumlah']}'),
                        trailing: Text('Rp ${item['harga']}'),
                      );
                    },
                  );
                },
              ),
            ),

            Row(
              children: [
                if (order.statusOrder == 'BARU')
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          _updateStatus(context, 'DIPROSES'),
                      child: const Text('Proses Pesanan'),
                    ),
                  ),
                if (order.statusOrder == 'DIPROSES')
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          _updateStatus(context, 'DIANTAR'),
                      child: const Text('Antar Makanan'),
                    ),
                  ),
                if (order.statusOrder == 'DIANTAR')
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          _updateStatus(context, 'SELESAI'),
                      child: const Text('Selesaikan'),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$label: $value'),
    );
  }
}
