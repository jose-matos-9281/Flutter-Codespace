import 'package:flutter/material.dart';
import '../pages/pagina1.dart';
import '../pages/pagina2.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menú Lateral'),
          ),
          ListTile(
            title: const Text('Página 1'),
            onTap: () {
              Navigator.pop(context); // Cerrar el menú lateral
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pagina1()),
              );
            },
          ),
          ListTile(
            title: const Text('Página 2'),
            onTap: () {
              Navigator.pop(context); // Cerrar el menú lateral
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Pagina2()),
              );
            },
          ),
          // Agrega más listTiles para más páginas
        ],
      ),
    );
  }
}
