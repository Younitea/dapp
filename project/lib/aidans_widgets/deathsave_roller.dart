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
  Future<int> _future = Future(() => 0);
  int _numSuccess = 0;
  int _numFails = 0;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            width: 350,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FillableColoredCircle(Colors.red, _numFails, 1),
                FillableColoredCircle(Colors.red, _numFails, 2),
                FillableColoredCircle(Colors.red, _numFails, 3),
                const VerticalDivider(
                  width: 5,
                  color: Colors.grey,
                ),
                FillableColoredCircle(Colors.green, _numSuccess, 3),
                FillableColoredCircle(Colors.green, _numSuccess, 2),
                FillableColoredCircle(Colors.green, _numSuccess, 1)
              ],
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return ElevatedButton(
                        onPressed: () {
                          if (_numSuccess == 3 || _numFails == 3) {
                            setState(() {
                              _numSuccess = 0;
                              _numFails = 0;
                            });
                          } else {
                            setState(() {
                              _future = rollSkill();
                            });
                            _future.then((value) {
                              if (value < 10) {
                                setState(() => _numFails++);
                              } else {
                                setState(() => _numSuccess++);
                              }
                            });
                          }
                        },
                        onLongPress: () {
                          setState(() {
                            _numSuccess = 0;
                            _numFails = 0;
                          });
                        },
                        child: const Text("Death Save"));
                }
              }),
        ],
      );
}
