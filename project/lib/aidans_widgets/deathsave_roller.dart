import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeathSaveRoller extends ConsumerStatefulWidget {
  const DeathSaveRoller({super.key});

  @override
  ConsumerState<DeathSaveRoller> createState() => _DeathSaveState();
}

class _DeathSaveState extends ConsumerState<DeathSaveRoller> {
  int _numSuccess = 0;
  int _numFails = 0;

  @override
  Widget build(BuildContext context) => const Text(":)");
}
