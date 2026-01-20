import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database/db_helper.dart';

// PAGES
import 'pages/splash_page.dart';
import 'pages/role_select_page.dart';
import 'pages/user/menu_page.dart';
import 'pages/seller/login_page.dart';
import 'pages/seller/order_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SQLite Windows
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // Init DB
  await DBHelper().database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/role': (context) => const RoleSelectPage(),

        // USER
        '/user-menu': (context) => MenuPage(),

        // SELLER
        '/seller-login': (context) => const SellerLoginPage(),
        '/seller-orders': (context) => OrderListPage(),
      },
    );
  }
}
