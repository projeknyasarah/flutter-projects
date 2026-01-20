import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../models/menu_model.dart';
import 'qris_page.dart';

class OrderFormPage extends StatefulWidget {
  final List<MenuModel> menuList;
  final Map<int, int> jumlahPesan;
  final int totalHarga;

  const OrderFormPage({
    super.key,
    required this.menuList,
    required this.jumlahPesan,
    required this.totalHarga,
  });

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final _namaCtrl = TextEditingController();
  final _hpCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  final _catatanCtrl = TextEditingController();

  String _tipe = 'TAKE';

  late String tanggal;
  late String jam;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    tanggal = "${now.year}-${now.month}-${now.day}";
    jam = "${now.hour}:${now.minute}:${now.second}";
  }

  Future<void> _simpanOrder() async {
    final db = await DBHelper().database;

    final orderId = await db.insert('orders', {
      'nama_pemesan': _namaCtrl.text,
      'no_hp': _hpCtrl.text,
      'alamat': _tipe == 'DELIVERY' ? _alamatCtrl.text : null,
      'catatan': _catatanCtrl.text,
      'tipe': _tipe,
      'metode_bayar': 'QRIS',
      'status_bayar': 'PENDING',
      'status_order': 'BARU',
      'total': widget.totalHarga,
      'tanggal': tanggal,
      'jam': jam,
    });

    for (final menu in widget.menuList) {
      final jumlah = widget.jumlahPesan[menu.id] ?? 0;
      if (jumlah > 0) {
        await db.insert('order_items', {
          'order_id': orderId,
          'menu_id': menu.id,
          'jumlah': jumlah,
          'harga': menu.harga,
        });
      }
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QRISPage(orderId: orderId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: _namaCtrl, decoration: const InputDecoration(labelText: 'Nama')),
            TextField(controller: _hpCtrl, decoration: const InputDecoration(labelText: 'No HP')),
            DropdownButtonFormField(
              value: _tipe,
              items: const [
                DropdownMenuItem(value: 'TAKE', child: Text('Take Away')),
                DropdownMenuItem(value: 'DELIVERY', child: Text('Delivery')),
              ],
              onChanged: (v) => setState(() => _tipe = v!),
            ),
            if (_tipe == 'DELIVERY')
              TextField(controller: _alamatCtrl, decoration: const InputDecoration(labelText: 'Alamat')),
            TextField(controller: _catatanCtrl, decoration: const InputDecoration(labelText: 'Catatan')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _simpanOrder, child: const Text('Lanjut Bayar')),
          ],
        ),
      ),
    );
  }
}
