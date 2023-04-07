import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'editable_attribute.dart';
import 'providers.dart';

class Skill {
  String skillName = '';
  bool prof = false;
  bool expert = false;
  int stat = 0;
  Skill(this.skillName, this.prof, this.expert, this.stat);
}

class PlayerView extends ConsumerWidget {
  PlayerView({super.key});

  int lastroll = 0;

  List<Skill> skillList = [
    Skill("acrobatics", true, false, 1),
    Skill("athletics", false, false, 0)
  ]; //needs to be stored eventually

  int _rollSkill(String skill, bool prof, bool exp, int stat) {
    //todo, ouput skill
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("Welcome to the Player View page!",
                style: TextStyle(fontSize: 24)),
            EditableAttribute<String>(nameProvider, "Player Name"),
            EditableAttribute<int>(healthProvider, "HP:"),
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
                                          lastroll = _rollSkill(
                                              skillList[index].skillName,
                                              skillList[index].prof,
                                              skillList[index].expert,
                                              skillList[index].stat);
                                        },
                                        child: Text("$lastroll"),
                                      )
                                    ])
                              ],
                            )),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
