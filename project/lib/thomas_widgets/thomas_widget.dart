import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'skill.dart';

class ThomasWidget extends ConsumerStatefulWidget {
  const ThomasWidget({super.key});

  @override
  ConsumerState<ThomasWidget> createState() => _ThomasWidgetState();
}

class _ThomasWidgetState extends ConsumerState<ThomasWidget> {
  int _lastroll = 0;

  final List<Skill> _skillList = [
    Skill("acrobatics", true, false, 1),
    Skill("athletics", false, false, 0)
  ]; //needs to be stored eventually

  int _rollSkill(String skill, bool prof, bool exp, int stat) {
    //todo, ouput skill
    return 0;
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
              height: 400,
              width: 400,
              child: ListView.builder(
                  itemCount: _skillList.length,
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
                                      _skillList[index].skillName,
                                      textAlign: TextAlign.left,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _lastroll = _rollSkill(
                                            _skillList[index].skillName,
                                            _skillList[index].prof,
                                            _skillList[index].expert,
                                            _skillList[index].stat);
                                      },
                                      child: Text("$_lastroll"),
                                    )
                                  ])
                            ],
                          )),
                    );
                  })),
        ],
      );
}
