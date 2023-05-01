import 'package:flutter/material.dart';
import 'package:project/views/gm_view.dart';
import 'package:project/views/player_view.dart';

class SelectView extends StatefulWidget {
  const SelectView({super.key});

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  var _selectedIndex = 0;

  static const _pages = <Widget>[
    PlayerView(),
    GmView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.call), label: "Player"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.stop), label: "Game Master")
            ],
            currentIndex: _selectedIndex,
            onTap: (idx) {
              setState(() {
                _selectedIndex = idx;
              });
            }),
        body: _pages.elementAt(_selectedIndex));
  }
}
