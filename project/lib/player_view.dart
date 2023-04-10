import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'editable_attribute.dart';
import 'health_modifier.dart';
import 'providers.dart';

class PlayerView extends ConsumerWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Welcome to the Player View page!",
                style: TextStyle(fontSize: 24)),
            EditableAttribute<String>(nameProvider, 32, "Player Name"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EditableAttribute<int>(healthProvider, 3, "HP:"),
                HealthModifier("Damage", Colors.red, true),
                HealthModifier("Heal", Colors.green, false),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
