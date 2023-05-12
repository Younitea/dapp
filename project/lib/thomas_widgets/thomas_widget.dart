import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import '../shared/providers.dart';
import '../shared/roll_skill.dart';
import 'skill.dart';

class ThomasWidget extends ConsumerWidget {
  const ThomasWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillList = ref.watch(skillProvider);
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: const [
                Text(
                  "Resting",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 12),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                onPressed: () async {
                  if (ref.read(hitDiceCount) > 0) {
                    ref.read(curHealthProvider.notifier).state =
                        await rollSkill(
                                ((ref.read(constitutionProvider) - 10) ~/ 2),
                                'none',
                                " 1d${ref.read(hitDice)} ") +
                            ref.read(curHealthProvider);
                    if (ref.read(curHealthProvider) >
                        ref.read(maxHealthProvider)) {
                      ref.read(curHealthProvider.notifier).state =
                          ref.read(maxHealthProvider);
                    }
                    ref.read(hitDiceCount.notifier).state =
                        ref.read(hitDiceCount) - 1;
                  }
                },
                child: const Text("SR"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                onPressed: () => {
                  ref.read(initiativeProvider.notifier).state = 0,
                  ref.read(curHealthProvider.notifier).state =
                      ref.read(maxHealthProvider),
                  ref.read(hitDiceCount.notifier).state =
                      ref.read(levelProvider)
                },
                child: const Text("LR"),
              ),
            ]),
            Row(
              children: const [
                Text(
                  "Hit Dice",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 12),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            Text("Hitdice Remaining: ${ref.watch(hitDiceCount.state).state}"),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                onPressed: () =>
                    {ref.read(hitDice.notifier).state = ref.read(hitDice) - 2},
                child: const Icon(Icons.exposure_minus_2_sharp),
              ),
              const SizedBox(width: 10),
              Text(
                "d${ref.watch(hitDice.state).state}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                onPressed: () =>
                    {ref.read(hitDice.notifier).state = ref.read(hitDice) + 2},
                child: const Icon(Icons.exposure_plus_2_sharp),
              ),
            ]),
            Row(
              children: const [
                Text(
                  "Free Dice Roll",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 12),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue),
                    onPressed: () async {
                      ref.read(skillRollProvider.notifier).state = -100;
                      ref.read(skillRollProvider.notifier).state =
                          await rollSkill(0, 'none', '1d4');
                    },
                    child: const Text("1d4")),
                const SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue),
                    onPressed: () async {
                      ref.read(skillRollProvider.notifier).state = -100;
                      ref.read(skillRollProvider.notifier).state =
                          await rollSkill(0, 'none', '1d6');
                    },
                    child: const Text("1d6")),
                const SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue),
                    onPressed: () async {
                      ref.read(skillRollProvider.notifier).state = -100;
                      ref.read(skillRollProvider.notifier).state =
                          await rollSkill(0, 'none', '1d8');
                    },
                    child: const Text("1d8")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue),
                    onPressed: () async {
                      ref.read(skillRollProvider.notifier).state = -100;
                      ref.read(skillRollProvider.notifier).state =
                          await rollSkill(0, 'none', '1d10');
                    },
                    child: const Text("1d10")),
                const SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue),
                    onPressed: () async {
                      ref.read(skillRollProvider.notifier).state = -100;
                      ref.read(skillRollProvider.notifier).state =
                          await rollSkill(0, 'none', '1d12');
                    },
                    child: const Text("1d12")),
                const SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue),
                    onPressed: () async {
                      ref.read(skillRollProvider.notifier).state = -100;
                      ref.read(skillRollProvider.notifier).state =
                          await rollSkill(0, 'none', '1d20');
                    },
                    child: const Text("1d20")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                    (ref.watch(skillRollProvider) == -100)
                        ? "Loading"
                        : "Output: ${ref.watch(skillRollProvider.state).state}"),
              ],
            ),
            Row(
              children: const [
                Text(
                  "Skills",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 12),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            ListView.builder(
                itemCount: skillList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Button(skillList[index]);
                })
          ],
        )));
  }
}

class Button extends ThomasWidget {
  const Button(this.skill, {super.key});

  final Skill skill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
        leading: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
            onPressed: () async {
              ref.read(skillRollProvider.notifier).state = -100;
              ref.read(skillRollProvider.notifier).state =
                  await rollSkill(skill.bonus, null, null);
            },
            child: Text("Roll: +${skill.bonus}")),
        title: Text(skill.skillName),
        trailing: Wrap(
          spacing: 10,
          children: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
              onPressed: () {
                ref.read(skillProvider.notifier).bumpBonus(skill);
              },
              child: const Icon(Icons.plus_one),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
              onPressed: () {
                ref.read(skillProvider.notifier).debumpBonus(skill);
              },
              child: const Text(
                "-1",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ));
  }
}

class SkillNotifier extends HydratedStateNotifier<List<Skill>> {
  SkillNotifier()
      : super(<Skill>[
          Skill("Acrobatics", 0),
          Skill("Animal handling", 0),
          Skill("Arcana", 0),
          Skill("Athletics", 0),
          Skill("Deception", 0),
          Skill("History", 0),
          Skill("Insight", 0),
          Skill("Intimidation", 0),
          Skill("Investigation", 0),
          Skill("Medicine", 0),
          Skill("Nature", 0),
          Skill("Perception", 0),
          Skill("Performance", 0),
          Skill("Persuasion", 0),
          Skill("Religon", 0),
          Skill("Sleight of Hand", 0),
          Skill("Stealth", 0),
          Skill("Survival", 0),
        ]);
  void bumpBonus(Skill skill) {
    final name = skill.skillName;
    state = state.map((skill) {
      return skill.skillName == name ? Skill(name, (skill.bonus + 1)) : skill;
    }).toList();
  }

  void debumpBonus(Skill skill) {
    final name = skill.skillName;
    state = state.map((skill) {
      return skill.skillName == name ? Skill(name, (skill.bonus - 1)) : skill;
    }).toList();
  }

  @override
  List<Skill> fromJson(Map<String, dynamic> json) =>
      (json['value'] as List<dynamic>)
          .map((skillJson) => Skill.fromJson(skillJson))
          .toList();

  @override
  Map<String, List<Skill>> toJson(List<Skill> state) => {'value': state};
}

final skillProvider =
    StateNotifierProvider<SkillNotifier, List<Skill>>((_) => SkillNotifier());
