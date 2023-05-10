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
import 'editable_name.dart';

class AidansWidget extends ConsumerWidget {
  const AidansWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Column(
              children: [
                const EditableName(28, 32),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Text(
                      "Stats",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 12),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 30,
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EditableAttribute(
                        provider: levelProvider,
                        maxLen: 2,
                        width: 70,
                        attributeLabel: "LVL",
                      ),
                      EditableAttribute(
                        provider: maxHealthProvider,
                        maxLen: 3,
                        width: 70,
                        attributeLabel: "Max HP",
                      ),
                      EditableAttribute(
                        provider: armorClassProvider,
                        maxLen: 2,
                        width: 70,
                        attributeLabel: "AC",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EditableAttribute(
                    provider: strengthProvider,
                    maxLen: 2,
                    width: 70,
                    fontSize: 16,
                    attributeLabel: "STR",
                  ),
                  EditableAttribute(
                    provider: dexterityProvider,
                    maxLen: 2,
                    width: 70,
                    fontSize: 16,
                    attributeLabel: "DEX",
                  ),
                  EditableAttribute(
                    provider: constitutionProvider,
                    maxLen: 2,
                    width: 70,
                    fontSize: 16,
                    attributeLabel: "CON",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EditableAttribute(
                    provider: intelligenceProvider,
                    maxLen: 2,
                    width: 70,
                    fontSize: 16,
                    attributeLabel: "INT",
                  ),
                  EditableAttribute(
                    provider: wisdomProvider,
                    maxLen: 2,
                    width: 70,
                    fontSize: 16,
                    attributeLabel: "WIS",
                  ),
                  EditableAttribute(
                    provider: charismaProvider,
                    maxLen: 2,
                    width: 70,
                    fontSize: 16,
                    attributeLabel: "CHA",
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                InitiativeRoller(),
                SizedBox(width: 10),
                SavingThrower()
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Text(
                  "Health/Damage",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 12),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const HealthModifier("Damage", Colors.red, true),
                  AttributeDisplay(
                    fontSize: 16,
                    width: 60,
                    height: 35,
                    provider: curHealthProvider,
                    attributeLabel: "HP",
                  ),
                  const HealthModifier("Heal", Colors.green, false),
                ],
              ),
            ),
            const DeathSaveRoller(),
            const SizedBox(height: 20),
            Row(
              children: const [
                Text(
                  "Saved Attacks",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 12),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 5),
            SavedAttack(savedAttackOneProvider),
            SavedAttack(savedAttackTwoProvider),
            SavedAttack(savedAttackThreeProvider),
          ],
        ),
      );
}
