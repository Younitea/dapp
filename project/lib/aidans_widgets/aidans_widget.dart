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
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          Column(
            children: [
              IntrinsicHeight(
                child: EditableAttribute<String>(
                  provider: nameProvider,
                  maxLen: 28,
                  fontSize: 32,
                  maxLines: 2,
                  alignment: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
                width: 225,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IntrinsicWidth(
                      child: EditableAttribute<int>(
                        provider: levelProvider,
                        maxLen: 2,
                        attributeLabel: "LVL: ",
                      ),
                    ),
                    const VerticalDivider(color: Colors.grey),
                    IntrinsicWidth(
                      child: EditableAttribute<int>(
                        provider: maxHealthProvider,
                        maxLen: 3,
                        attributeLabel: "Max HP: ",
                      ),
                    ),
                    const VerticalDivider(color: Colors.grey),
                    IntrinsicWidth(
                      child: EditableAttribute<int>(
                        provider: armorClassProvider,
                        maxLen: 2,
                        attributeLabel: "AC: ",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const HealthModifier("Damage", Colors.red, true),
                AttributeDisplay(
                  fontSize: 20,
                  provider: curHealthProvider,
                  attributeLabel: "HP: ",
                ),
                const HealthModifier("Heal", Colors.green, false),
              ],
            ),
          ),
          const DeathSaveRoller(),
          const SizedBox(height: 20),
          SizedBox(
            width: 250,
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IntrinsicWidth(
                  child: EditableAttribute<int>(
                    provider: strengthProvider,
                    maxLen: 2,
                    fontSize: 20,
                    attributeLabel: "STR: ",
                  ),
                ),
                const VerticalDivider(color: Colors.grey),
                IntrinsicWidth(
                  child: EditableAttribute<int>(
                    provider: dexterityProvider,
                    maxLen: 2,
                    fontSize: 20,
                    attributeLabel: "DEX: ",
                  ),
                ),
                const VerticalDivider(color: Colors.grey),
                IntrinsicWidth(
                  child: EditableAttribute<int>(
                    provider: constitutionProvider,
                    maxLen: 2,
                    fontSize: 20,
                    attributeLabel: "CON: ",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 250,
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IntrinsicWidth(
                  child: EditableAttribute<int>(
                    provider: intelligenceProvider,
                    maxLen: 2,
                    fontSize: 20,
                    attributeLabel: "INT: ",
                  ),
                ),
                const VerticalDivider(color: Colors.grey),
                IntrinsicWidth(
                  child: EditableAttribute<int>(
                    provider: wisdomProvider,
                    maxLen: 2,
                    fontSize: 20,
                    attributeLabel: "WIS: ",
                  ),
                ),
                const VerticalDivider(color: Colors.grey),
                IntrinsicWidth(
                  child: EditableAttribute<int>(
                    provider: charismaProvider,
                    maxLen: 2,
                    fontSize: 20,
                    attributeLabel: "CHA: ",
                  ),
                ),
              ],
            ),
          ),
          const SavingThrower(),
          const InitiativeRoller(),
          const SizedBox(height: 20),
          SavedAttack(savedAttackOneProvider),
          SavedAttack(savedAttackTwoProvider),
          SavedAttack(savedAttackThreeProvider),
        ],
      );
}
