import 'db_helper.dart';
import '../models/menu_model.dart';

class MenuDB {
  static Future<List<MenuModel>> getMenuAktif() async {
    final db = await DBHelper().database;

    final result = await db.query(
      'menu',
      where: 'aktif = ?',
      whereArgs: [1],
    );

    return result.map((e) => MenuModel.fromMap(e)).toList();
  }
}
