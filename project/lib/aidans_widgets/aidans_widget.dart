import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../shared/providers.dart';
import '../shared/editable_attribute.dart';
import 'attribute_display.dart';
import 'initiative_roller.dart';
import 'health_modifier.dart';
import 'deathsave_roller.dart';
import 'saved_attack.dart';
import 'saving_thrower.dart';

class AidansWidget extends ConsumerWidget {
  const AidansWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(children: [
        EditableAttribute<String>(
          provider: nameProvider,
          maxLen: 24,
          width: 500,
          fontSize: 32,
          alignment: TextAlign.center,
        ),
        EditableAttribute<int>(
          provider: levelProvider,
          maxLen: 2,
          width: 50,
          attributeLabel: "LVL: ",
        ),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            EditableAttribute<int>(
              provider: maxHealthProvider,
              maxLen: 3,
              width: 105,
              fontSize: 18,
              attributeLabel: "Max HP: ",
            ),
            AttributeDisplay(
              provider: curHealthProvider,
              width: 130,
              fontSize: 18,
              attributeLabel: "Current HP: ",
            ),
          ]),
          const SizedBox(width: 5),
          const HealthModifier("Damage", Colors.red, true),
          const SizedBox(width: 5),
          const HealthModifier("Heal", Colors.green, false),
        ]),
        const DeathSaveRoller(),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const InitiativeRoller(),
          const SizedBox(width: 10),
          EditableAttribute<int>(
            provider: armorClassProvider,
            maxLen: 2,
            width: 75,
            fontSize: 20,
            attributeLabel: "AC: ",
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          EditableAttribute<int>(
            provider: strengthProvider,
            maxLen: 2,
            width: 75,
            fontSize: 20,
            attributeLabel: "STR: ",
          ),
          EditableAttribute<int>(
            provider: dexterityProvider,
            maxLen: 2,
            width: 75,
            fontSize: 20,
            attributeLabel: "DEX: ",
          ),
          EditableAttribute<int>(
            provider: constitutionProvider,
            maxLen: 2,
            width: 75,
            fontSize: 20,
            attributeLabel: "CON: ",
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          EditableAttribute<int>(
            provider: intelligenceProvider,
            maxLen: 2,
            width: 75,
            fontSize: 20,
            attributeLabel: "INT: ",
          ),
          EditableAttribute<int>(
            provider: wisdomProvider,
            maxLen: 2,
            width: 75,
            fontSize: 20,
            attributeLabel: "WIS: ",
          ),
          EditableAttribute<int>(
            provider: charismaProvider,
            maxLen: 2,
            width: 75,
            fontSize: 20,
            attributeLabel: "CHA: ",
          ),
        ]),
        const SavingThrower(),
        SavedAttack(savedAttackOneProvider),
        SavedAttack(savedAttackTwoProvider),
        SavedAttack(savedAttackThreeProvider),
      ]);
}
