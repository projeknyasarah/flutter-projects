import 'package:flutter/material.dart';

import '../../database/menu_db.dart';
import '../../models/menu_model.dart';
import 'order_form_page.dart';
import 'order_list_page.dart'; // ✅ TAMBAHAN

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuModel> _menuList = [];
  final Map<int, int> _jumlahPesan = {};

  int get totalHarga {
    int total = 0;
    for (final menu in _menuList) {
      final id = menu.id;
      if (id == null) continue;

      final jumlah = _jumlahPesan[id] ?? 0;
      total += jumlah * menu.harga;
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    _loadMenu();
  }

  Future<void> _loadMenu() async {
    final data = await MenuDB.getMenuAktif();
    setState(() => _menuList = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Sarapan'),
        actions: [
          // ===================== PESANAN SAYA =====================
          IconButton(
            tooltip: 'Pesanan Saya',
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UserOrderListPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _menuList.isEmpty
          ? const Center(child: Text('Menu belum tersedia'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _menuList.length,
                    itemBuilder: (context, index) {
                      final menu = _menuList[index];
                      final id = menu.id!;
                      final jumlah = _jumlahPesan[id] ?? 0;

                      return ListTile(
                        title: Text(menu.nama),
                        subtitle: Text('Rp ${menu.harga}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: jumlah > 0
                                  ? () {
                                      setState(() {
                                        _jumlahPesan[id] = jumlah - 1;
                                      });
                                    }
                                  : null,
                            ),
                            Text(jumlah.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _jumlahPesan[id] = jumlah + 1;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // ===================== FOOTER =====================
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: Rp $totalHarga',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: totalHarga > 0
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OrderFormPage(
                                      menuList: _menuList,
                                      jumlahPesan: _jumlahPesan,
                                      totalHarga: totalHarga,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        child: const Text('Pesan'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
