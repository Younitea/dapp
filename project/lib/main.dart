import 'package:flutter/material.dart';
import 'select_view.dart';
import 'player_view.dart';
import 'gm_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dungeons and Dragons for the Mathematically Impaired',
        initialRoute: '/',
        routes: {
          '/': (context) => const SelectView(),
          '/player_view': (context) => PlayerView(),
          '/gm_view': (context) => GmView(),
        });
  }
}
