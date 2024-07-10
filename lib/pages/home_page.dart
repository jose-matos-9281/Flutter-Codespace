import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';
// import 'pagina1.dart';
// import 'pagina2.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App con Menú Lateral')),
      drawer: const DrawerMenu(),
      body: const Center(
        child: Text('Página de inicio'),
      ),
    );
  }
}
