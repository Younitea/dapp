import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import '../shared/editable_attribute.dart';
import 'skill.dart';

class ThomasWidget extends ConsumerWidget {
  const ThomasWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillList = ref.watch(skillProvider);
    return SizedBox(
        height: 400,
        width: 400,
        child: ListView.builder(
            itemCount: skillList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Button(skillList[index]);
            }));
  }
}

class Button extends ThomasWidget {
  const Button(this.skill, {super.key});

  final Skill skill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Text("${skill.bonus}"),
      title: Text(skill.skillName),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
        onPressed: () {
          ref.read(skillProvider.notifier).bumpBonus(skill);
        },
        child: const Text('Bump Prof'),
      ),
    );
  }
}

class SkillNotifier extends HydratedStateNotifier<List<Skill>> {
  SkillNotifier()
      : super(<Skill>[
          Skill("Acrobatics", 0, 0),
          Skill("Animal handling", 0, 0),
          Skill("Arcana", 0, 0),
          Skill("Athletics", 0, 0),
          Skill("Deception", 0, 0),
          Skill("History", 0, 0),
          Skill("Insight", 0, 0),
          Skill("Intimidation", 0, 0),
          Skill("Investigation", 0, 0),
          Skill("Medicine", 0, 0),
          Skill("Nature", 0, 0),
          Skill("Perception", 0, 0),
          Skill("Performance", 0, 0),
          Skill("Persuasion", 0, 0),
          Skill("Religon", 0, 0),
          Skill("Sleight of Hand", 0, 0),
          Skill("Stealth", 0, 0),
          Skill("Survival", 0, 0),
        ]);
  void bumpBonus(Skill skill) {
    final name = skill.skillName;
    state = state.map((skill) {
      return skill.skillName == name
          ? Skill(name, (skill.bonus + 1), skill.stat)
          : skill;
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
