import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class SellerLoginPage extends StatefulWidget {
  const SellerLoginPage({Key? key}) : super(key: key);

  @override
  State<SellerLoginPage> createState() => _SellerLoginPageState();
}

class _SellerLoginPageState extends State<SellerLoginPage> {
  final _pinCtrl = TextEditingController();
  String? error;

  static const String sellerPin = '1234';

  void _login() {
    if (_pinCtrl.text == sellerPin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SellerDashboardPage()),
      );
    } else {
      setState(() {
        error = 'PIN salah';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Penjual')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Masukkan PIN Penjual',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pinCtrl,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'PIN',
                errorText: error,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
