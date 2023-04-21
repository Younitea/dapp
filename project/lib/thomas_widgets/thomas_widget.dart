import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:project/thomas_widgets/roll_skill.dart';
import '../providers.dart';
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
              return GestureDetector(
                onTap: () {
                  print("tapped on");
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                skillList[index].skillName,
                                textAlign: TextAlign.left,
                              ),
                              GestureDetector(
                                onTap: () {
                                  rollSkill(
                                      "",
                                      skillList[index].prof,
                                      skillList[index].expert,
                                      skillList[index].stat);
                                },
                                child: const Text("placeholder"),
                              )
                            ])
                      ],
                    )),
              );
            }));
  }
}

class SkillWidget extends StateNotifier<List<Skill>> {
  SkillWidget() : super(const []);
  static final provider =
      StateNotifierProvider<SkillWidget, List<Skill>>((ref) {
    return SkillWidget();
  });

  void setProf(Skill skill) {}
}
/*
class ThomasWidget extends ConsumerWidget {
  const ThomasWidget({super.key});
  
  static final Provider = StateNotifierProvider<ThomasWidget, List<Skill>>((ref))
  int _rollSkill(String skill, bool prof, bool exp, int stat) {
    //todo, ouput skill
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    List<Skill> skillList = ref.watch(skillProvider);
        children: [
          SizedBox(
              height: 400,
              width: 400,
              child: ListView.builder(
                  itemCount: skillList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print("tapped on");
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      skillList[index].skillName,
                                      textAlign: TextAlign.left,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _rollSkill(
                                            skillList[index].skillName,
                                            skillList[index].prof,
                                            skillList[index].expert,
                                            skillList[index].stat);
                                      },
                                      child: Text("placeholder"),
                                    )
                                  ])
                            ],
                          )),
                    );
                  })),
        ],
      );
}*/
