import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trigg_app/providers/user_provider.dart';
import 'package:trigg_app/routes.dart';
import 'package:trigg_app/widgets/trigg_drawer.dart';
import 'package:trigg_app/widgets/trigg_app_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _routes =
      TriggRoutes.routes.where((element) => element.icon != null).toList();
  int _selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TriggAppBar(title: _routes[_selectedScreen].title),
      drawer: TriggDrawer(),
      body: _routes[_selectedScreen].screen,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedScreen,
          items: _routes
              .map(
                  (e) => BottomNavigationBarItem(icon: e.icon!, label: e.title))
              .toList()),
    );
  }

  void _selectPage(int index) {
    _routes.where((element) => element.icon != null);
    setState(() {
      _selectedScreen = index;
    });
  }
}
