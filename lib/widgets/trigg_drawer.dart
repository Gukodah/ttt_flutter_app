import 'package:flutter/material.dart';

class TriggDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('Precisa de ajuda?')),
          ListTile(title: Text('Fale com a gente'))
        ],
      ),
    );
  }
}
