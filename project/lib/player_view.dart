import 'package:flutter/material.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
          child: Text("Welcome to the Player View page!",
              style: TextStyle(fontSize: 24))),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
