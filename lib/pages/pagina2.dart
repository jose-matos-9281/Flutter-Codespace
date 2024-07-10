import 'package:flutter/material.dart';

class Pagina2 extends StatelessWidget {
  const Pagina2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página 2')),
      body: const Center(
        child: Text('Contenido de la página 2'),
      ),
    );
  }
}
