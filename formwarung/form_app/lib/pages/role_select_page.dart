import 'package:flutter/material.dart';

class RoleSelectPage extends StatelessWidget {
  const RoleSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Peran'),
        automaticallyImplyLeading: false, // ga ada back ke splash
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Masuk sebagai',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              /// PEMBELI
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user-menu');
                },
                child: const Text('Pembeli'),
              ),

              const SizedBox(height: 16),

              /// PENJUAL
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/seller-login');
                },
                child: const Text('Penjual'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
