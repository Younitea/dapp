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
    return Column(
      children: [
        Text("Hitdice Remaining: ${ref.watch(hitDiceCount.state).state}"),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
            onPressed: () async {
              if (ref.read(hitDiceCount) > 0) {
                ref.read(curHealthProvider.notifier).state = await rollSkill(
                        ((ref.read(constitutionProvider) - 10) ~/ 2),
                        'none',
                        "1d${ref.read(hitDice)}") +
                    ref.read(curHealthProvider);
                if (ref.read(curHealthProvider) > ref.read(maxHealthProvider)) {
                  ref.read(curHealthProvider.notifier).state =
                      ref.read(maxHealthProvider);
                }
                ref.read(hitDiceCount.notifier).state =
                    ref.read(hitDiceCount) - 1;
              }
            },
            child: const Icon(Icons.fastfood),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
            onPressed: () => {
              ref.read(initiativeProvider.notifier).state = 0,
              ref.read(curHealthProvider.notifier).state =
                  ref.read(maxHealthProvider),
              ref.read(hitDiceCount.notifier).state = ref.read(levelProvider)
            },
            child: const Icon(Icons.bed),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
            onPressed: () =>
                {ref.read(hitDice.notifier).state = ref.read(hitDice) - 2},
            child: const Icon(Icons.exposure_minus_2_sharp),
          ),
          Text("d${ref.watch(hitDice.state).state}"),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
            onPressed: () =>
                {ref.read(hitDice.notifier).state = ref.read(hitDice) + 2},
            child: const Icon(Icons.exposure_plus_2_sharp),
          ),
        ]),
        Text("Output: ${ref.watch(skillRollProvider.state).state}"),
        SizedBox(
            height: 400,
            width: 400,
            child: ListView.builder(
                itemCount: skillList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Button(skillList[index]);
                }))
      ],
    );
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
              child: const Icon(Icons.remove),
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
