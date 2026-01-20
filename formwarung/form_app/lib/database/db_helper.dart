import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'warung_sarapan.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE menu (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        harga INTEGER,
        aktif INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_pemesan TEXT,
        no_hp TEXT,
        alamat TEXT,
        catatan TEXT,
        tipe TEXT,
        metode_bayar TEXT,
        status_bayar TEXT,
        status_order TEXT,
        total INTEGER,
        tanggal TEXT,
        jam TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER,
        menu_id INTEGER,
        jumlah INTEGER,
        harga INTEGER
      )
    ''');

    await db.insert('menu', {'nama': 'Nasi Uduk', 'harga': 8000, 'aktif': 1});
    await db.insert('menu', {'nama': 'Nasi Goreng', 'harga': 12000, 'aktif': 1});
  }
}
