import 'package:flutter/material.dart';
import '../../database/order_db.dart';
import '../../models/order_model.dart';

class OrderStatusPage extends StatefulWidget {
  final int orderId;

  const OrderStatusPage({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  late Future<OrderModel?> _orderFuture;

  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  void _loadOrder() {
    _orderFuture = OrderDB().getOrderById(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Pesanan')),
      body: FutureBuilder<OrderModel?>(
        future: _orderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Pesanan tidak ditemukan'));
          }

          final order = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _info('Nama', order.namaPemesan),
                _info('Tipe', order.tipe),
                _info('Total', 'Rp ${order.total}'),
                _info('Tanggal', order.tanggal),
                _info('Jam', order.jam),
                const SizedBox(height: 20),

                const Text(
                  'Status Pesanan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                _statusBadge(order.statusOrder),
                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    setState(_loadOrder); // refresh status
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Status'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text('$label: $value'),
    );
  }

  Widget _statusBadge(String status) {
    Color color;
    String text;

    switch (status) {
      case 'BARU':
        color = Colors.orange;
        text = 'Menunggu Diproses';
        break;
      case 'DIPROSES':
        color = Colors.blue;
        text = 'Sedang Diproses';
        break;
      case 'DIANTAR':
        color = Colors.green;
        text = 'Sedang Diantar';
        break;
      case 'SELESAI':
        color = Colors.grey;
        text = 'Pesanan Selesai';
        break;
      default:
        color = Colors.black;
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 12, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
