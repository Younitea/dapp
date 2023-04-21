import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'editable_attribute.dart';
import 'attribute_display.dart';
import 'initiative_roller.dart';
import 'health_modifier.dart';
import '../shared/providers.dart';

class AidansWidget extends ConsumerWidget {
  const AidansWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          EditableAttribute<String>(nameProvider, 32, 100, "Player Name"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EditableAttribute<int>(maxHealthProvider, 3, 75, "Max HP:"),
              AttributeDisplay(curHealthProvider, 100, "Current HP:"),
              const HealthModifier("Damage", Colors.red, true),
              const HealthModifier("Heal", Colors.green, false),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const InitiativeRoller(),
              EditableAttribute<int>(armorClassProvider, 2, 50, "AC:"),
            ],
          ),
        ],
      );
}
