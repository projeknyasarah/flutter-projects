import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';
import '../models/order_model.dart';

class OrderDB {
  /* ===================== ORDER LIST (SELLER) ===================== */
  Future<List<OrderModel>> getAllOrders() async {
    final db = await DBHelper().database;

    final result = await db.query(
      'orders',
      orderBy: 'tanggal DESC, jam DESC',
    );

    return result.map((e) => OrderModel.fromMap(e)).toList();
  }

  /* ===================== ORDER ITEMS ===================== */
Future<List<Map<String, dynamic>>> getOrderItems(int orderId) async {
  final db = await DBHelper().database;

  return await db.rawQuery('''
    SELECT 
      m.nama AS nama_menu,
      oi.jumlah,
      oi.harga
    FROM order_items oi
    LEFT JOIN menu m ON m.id = oi.menu_id
    WHERE oi.order_id = ?
  ''', [orderId]);
}



  /* ===================== GET ORDER BY ID ===================== */
  Future<OrderModel?> getOrderById(int orderId) async {
    final db = await DBHelper().database;

    final result = await db.query(
      'orders',
      where: 'id = ?',
      whereArgs: [orderId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return OrderModel.fromMap(result.first);
    }
    return null;
  }
}
