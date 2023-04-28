import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeathSaveRoller extends ConsumerStatefulWidget {
  const DeathSaveRoller({super.key});

  @override
  ConsumerState<DeathSaveRoller> createState() => _DeathSaveState();
}

final deathCircle = Container(
  width: 40,
  height: 40,
  decoration: BoxDecoration(
    //   color: Colors.red,
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.red,
      width: 2,
    ),
  ),
);

final lifeCircle = Container(
  width: 40,
  height: 40,
  decoration: BoxDecoration(
    //   color: Colors.green,
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.green,
      width: 2,
    ),
  ),
);

class _DeathSaveState extends ConsumerState<DeathSaveRoller> {
  int _numSuccess = 0;
  int _numFails = 0;

  @override
  Widget build(BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        deathCircle,
        deathCircle,
        deathCircle,
        ElevatedButton(onPressed: () => null, child: const Text("Death Save")),
        lifeCircle,
        lifeCircle,
        lifeCircle
      ]);
}
