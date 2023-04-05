import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'editable_attribute.dart';
import 'providers.dart';

class PlayerView extends ConsumerWidget {
  PlayerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Welcome to the Player View page!",
                style: TextStyle(fontSize: 24)),
            EditableAttribute<String>(nameProvider, "Player Name"),
            EditableAttribute<int>(healthProvider, "HP:")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
