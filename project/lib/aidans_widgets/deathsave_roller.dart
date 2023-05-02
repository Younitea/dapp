import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/shared/roll_skill.dart';
import 'fillable_colored_circle.dart';

class DeathSaveRoller extends ConsumerStatefulWidget {
  const DeathSaveRoller({super.key});

  @override
  ConsumerState<DeathSaveRoller> createState() => _DeathSaveState();
}

class _DeathSaveState extends ConsumerState<DeathSaveRoller> {
  int _numSuccess = 0;
  int _numFails = 0;

  @override
  Widget build(BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        FillableColoredCircle(Colors.red, _numFails, 1),
        FillableColoredCircle(Colors.red, _numFails, 2),
        FillableColoredCircle(Colors.red, _numFails, 3),
        ElevatedButton(
            onPressed: () async {
              if (_numSuccess == 3 || _numFails == 3) {
                setState(() {
                  _numSuccess = 0;
                  _numFails = 0;
                });
              } else {
                int roll = await rollSkill(0, null, null);
                if (roll < 10) {
                  setState(() => _numFails++);
                } else {
                  setState(() => _numSuccess++);
                }
              }
            },
            onLongPress: () {
              setState(() {
                _numSuccess = 0;
                _numFails = 0;
              });
            },
            child: const Text("Death Save")),
        FillableColoredCircle(Colors.green, _numSuccess, 3),
        FillableColoredCircle(Colors.green, _numSuccess, 2),
        FillableColoredCircle(Colors.green, _numSuccess, 1)
      ]);
}
