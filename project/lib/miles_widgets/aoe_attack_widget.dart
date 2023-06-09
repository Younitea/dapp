import 'dart:math';

import 'package:anydice/anydice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/miles_widgets/unit_editor.dart';

import 'unit_marker.dart';

class AoeAttackDialog extends StatefulWidget {
  const AoeAttackDialog(
      {super.key,
      required this.units,
      required this.selected,
      required this.onRollComplete});

  final List<UnitData> units;
  final List<int> selected;
  final Function(List<UnitData>) onRollComplete;

  @override
  State<StatefulWidget> createState() => _AoeAttackState();
}

const kStatTypes = ["STR", "DEX", "CON", "INT", "WIS", "CHA"];

class _AoeAttackState extends State<AoeAttackDialog> {
  late String _selectedNamesText;
  String _selectedStatType = kStatTypes[0];
  String _selectedResistance = kResistances[0];

  final _dcController = TextEditingController();
  final _damageController = TextEditingController();

  bool _saveAll = false;
  bool _saveHalf = false;

  bool _isLoading = false;

  bool _damageInvalid = false;
  bool _dcInvalid = false;

  @override
  void initState() {
    _selectedNamesText =
        "Selected: ${widget.units.asMap().entries.where((entry) => widget.selected.contains(entry.key)).map((entry) => entry.value.name).join(", ")}";

    super.initState();
  }

  @override
  void dispose() {
    _dcController.dispose();
    _damageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        width: 350,
        height: 500,
        child: const Center(
          child: SizedBox(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(
              value: null,
              strokeWidth: 7.0,
            ),
          ),
        ),
      );
    }

    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    "Damage",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    _selectedNamesText,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _damageController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Damage",
                  errorText: _damageInvalid ? "Value can't be empty" : null,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2)
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _dcController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Player DC",
                  errorText: _dcInvalid ? "Value can't be empty" : null,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2)
                ],
              ),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(
                  child: DropdownButton(
                    value: _selectedStatType,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatType = value!;
                      });
                    },
                    items: kStatTypes
                        .map((stat) =>
                            DropdownMenuItem(child: Text(stat), value: stat))
                        .toList(),
                  ),
                ),
              ]),
              Row(children: [
                Expanded(
                  child: DropdownButton(
                    value: _selectedResistance,
                    onChanged: (value) {
                      setState(() {
                        _selectedResistance = value!;
                      });
                    },
                    items: kResistances
                        .map((stat) =>
                            DropdownMenuItem(child: Text(stat), value: stat))
                        .toList(),
                  ),
                ),
              ]),
              CheckboxListTile(
                title: const Text("Save for 1/2"),
                value: _saveHalf,
                onChanged: (_) {
                  setState(() {
                    _saveAll = false;
                    _saveHalf = !_saveHalf;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Save for all"),
                value: _saveAll,
                onChanged: (_) {
                  setState(() {
                    _saveHalf = false;
                    _saveAll = !_saveAll;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => _attack(context),
                      child: const Text("Attack"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _attack(BuildContext context) async {
    if (_damageController.text.isEmpty || _dcController.text.isEmpty) {
      setState(() {
        _dcInvalid = _dcController.text.isEmpty;
        _damageInvalid = _damageController.text.isEmpty;
      });

      return;
    }

    final damage = int.parse(_damageController.text);
    final dc = int.parse(_dcController.text);

    setState(() {
      _isLoading = true;
    });

    List<int> deadUnits = [];
    List<int> damageTaken = [];

    // first we do damage to each unit
    for (final id in widget.selected) {
      var localDamage = damage;

      // if -50% resistant
      if (widget.units[id]
          .getResistance(kResistances.indexOf(_selectedResistance))) {
        localDamage = (localDamage / 2).floor();
      }

      // if immune
      if (widget.units[id]
          .getResistance(13 + kResistances.indexOf(_selectedResistance))) {
        localDamage = 0;
      }

      widget.units[id].hp -= damage;
      if (widget.units[id].hp < 0) {
        deadUnits.add(id);
        damageTaken.add(damage);
      }
    }

    if (_saveAll || _saveHalf) {
      // we roll a 1d20 for each dead unit. if we need to do saving throws
      var rolls = (await Future.wait(
              widget.selected.map((_) => AnyDiceWrapper.roll("output 1d20"))))
          .map((probabilityDistribution) =>
              generateRandomValue(probabilityDistribution))
          .toList();

      // for each dead unit, based on the setting the user chose for saving throws
      for (var i = 0; i < deadUnits.length; i++) {
        var throwResult = rolls[i];
        final unit = widget.units[deadUnits[i]];

        switch (_selectedStatType) {
          case "STR":
            throwResult += modifier(unit.str);
            break;
          case "DEX":
            throwResult += modifier(unit.dex);
            break;
          case "CON":
            throwResult += modifier(unit.con);
            break;
          case "INT":
            throwResult += modifier(unit.intt);
            break;
          case "WIS":
            throwResult += modifier(unit.wis);
            break;
          case "CHA":
            throwResult += modifier(unit.cha);
            break;
        }

        if (throwResult >= dc) {
          if (_saveAll) {
            widget.units[deadUnits[i]].hp += damage;
          } else if (_saveHalf) {
            widget.units[deadUnits[i]].hp += (damage / 2).floor();
          }
        }
      }
    }

    Navigator.of(context).pop();

    // return all non-dead units
    widget.onRollComplete(widget.units.where((unit) => unit.hp > 0).toList());
  }
}

int modifier(int stat) {
  return ((stat - 10) / 2).floor();
}
