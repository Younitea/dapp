import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../shared/roll_skill.dart';
import '../shared/providers.dart';
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
            itemBuilder: (context, index) {
              return Button(skillList[index]);
            }));
  }
}

class Button extends ConsumerWidget{
  const Button(this.skill, {super.key});

  final Skill skill;

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return ListTile(
      tileColor: Colors.orange, 
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
        onPressed: (){
          ref.read(skillProvider.notifier).setProf(skill);
        },
        child: const Text('Swap Prof'),
      ),
    );
  }
}

class SkillNotifier extends StateNotifier<List<Skill>> {
  SkillNotifier() : super(const []);
  void setProf(Skill skill) {
    state.map((skill){
      return Skill(skill.skillName, !skill.prof, skill.expert, skill.stat)
    })  .toList();
  }
}

 final provider =
      StateNotifierProvider<SkillNotifier, List<Skill>>((ref) {
    return SkillNotifier();
  });
