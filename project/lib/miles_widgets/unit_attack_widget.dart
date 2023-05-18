import 'dart:math';

import 'package:anydice/anydice.dart';
import 'package:flutter/material.dart';
import 'package:project/aidans_widgets/dice_parser.dart';

class UnitAttackDialog extends StatefulWidget {
  const UnitAttackDialog({super.key});

  @override
  State<StatefulWidget> createState() => _UnitAttackDialogState();
}

class _UnitAttackDialogState extends State<UnitAttackDialog> {
  int? _conditionResult;
  int? _damageResult;

  bool _isLoading = false;

  final TextEditingController _modifierController = TextEditingController();
  final TextEditingController _damageController = TextEditingController();

  bool _modifierInvalid = false;
  bool _damageInvalid = false;

  @override
  void dispose() {
    _modifierController.dispose();
    _damageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_conditionResult != null && _damageResult != null) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Attack Roll result: $_conditionResult\ndamage result: $_damageResult",
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    if (_isLoading) {
      return const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: _modifierController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Attack Roll",
              errorText: _modifierInvalid ? "Invalid dice string." : null,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _damageController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Damage",
              errorText: _damageInvalid ? "Invalid dice string." : null,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _roll(context),
                child: const Text("Roll"),
              )
            ],
          ),
        ]),
      ),
    );
  }

  Future<void> _roll(BuildContext context) async {
    _modifierInvalid = !diceParser.hasMatch(_modifierController.text);
    _damageInvalid = !diceParser.hasMatch(_damageController.text);

    if (_modifierInvalid || _damageInvalid) {
      setState(() {});
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var rollResults = (await Future.wait([
      AnyDiceWrapper.roll("output ${_modifierController.text}"),
      AnyDiceWrapper.roll("output ${_damageController.text}")
    ]))
        .map((probabilityDistribution) =>
            generateRandomValue(probabilityDistribution))
        .toList();

    var intValue = Random().nextInt(20) + 1;
    _conditionResult = rollResults[0] + intValue;
    _damageResult = rollResults[1];

    setState(() {
      _isLoading = false;
    });
  }
}
