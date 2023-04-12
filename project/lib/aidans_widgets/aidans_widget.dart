import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'editable_attribute.dart';
import 'health_modifier.dart';
import '../providers.dart';

class AidansWidget extends ConsumerWidget {
  const AidansWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          EditableAttribute<String>(nameProvider, 32, "Player Name"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EditableAttribute<int>(healthProvider, 3, "HP:"),
              const HealthModifier("Damage", Colors.red, true),
              const HealthModifier("Heal", Colors.green, false),
            ],
          ),
        ],
      );
}
