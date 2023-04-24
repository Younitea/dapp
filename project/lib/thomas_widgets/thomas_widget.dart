import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
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
      leading:
          Icon(skill.prof ? Icons.check_box : Icons.check_box_outline_blank),
      title: Text(skill.skillName),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
        onPressed: () {
          ref.read(skillProvider.notifier).setProf(skill);
        },
        child: const Text('Swap Prof'),
      ),
    );
  }
}

class SkillNotifier extends StateNotifier<List<Skill>> {
  SkillNotifier()
      : super(<Skill>[
          Skill("Acrobatics", false, false, 0),
          Skill("Animal handling", false, false, 0),
          Skill("Arcana", false, false, 0),
          Skill("Athletics", false, false, 0),
          Skill("Deception", false, false, 0),
          Skill("History", false, false, 0),
          Skill("Insight", false, false, 0),
          Skill("Intimidation", false, false, 0),
          Skill("Investigation", false, false, 0),
          Skill("Medicine", false, false, 0),
          Skill("Nature", false, false, 0),
          Skill("Perception", false, false, 0),
          Skill("Performance", false, false, 0),
          Skill("Persuasion", false, false, 0),
          Skill("Religon", false, false, 0),
          Skill("Sleight of Hand", false, false, 0),
          Skill("Stealth", false, false, 0),
          Skill("Survival", false, false, 0),
        ]);
  void setProf(Skill skill) {
    final name = skill.skillName;
    state = state.map((skill) {
      return skill.skillName == name
          ? Skill(name, !skill.prof, skill.expert, skill.stat)
          : skill;
    }).toList();
  }
}

final skillProvider = StateNotifierProvider<SkillNotifier, List<Skill>>((ref) {
  return SkillNotifier();
});
