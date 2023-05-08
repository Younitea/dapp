import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'unit_marker.dart';
import 'package:flutter/material.dart';

class UnitEditor extends ConsumerStatefulWidget {
  const UnitEditor({super.key, this.unitData, required this.onEdit});

  final UnitData? unitData;
  final Function(UnitData) onEdit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UnitEditorState();
}

class _UnitEditorState extends ConsumerState<UnitEditor> {
  final _nameController = TextEditingController();
  final _strController = TextEditingController();
  final _dexController = TextEditingController();
  final _conController = TextEditingController();
  final _intController = TextEditingController();
  final _wisController = TextEditingController();
  final _chaController = TextEditingController();

  late UnitData _unit;

  static const RESISTANCES = [
    "Acid",
    "Cold",
    "Fire",
    "Force",
    "Lightning",
    "Necrotic",
    "Poison",
    "Psychic",
    "Radiant",
    "Thunder",
    "Bludgeoning",
    "Slashing",
    "Piercing"
  ];

  @override
  void initState() {
    super.initState();
    _unit = widget.unitData ??
        UnitData(
            name: "",
            hp: 100,
            str: 0,
            dex: 0,
            con: 0,
            intt: 0,
            wis: 0,
            cha: 0,
            resistances: 0);

    _nameController.text = _unit.name.toString();
    _strController.text = _unit.str.toString();
    _dexController.text = _unit.dex.toString();
    _conController.text = _unit.con.toString();
    _intController.text = _unit.intt.toString();
    _wisController.text = _unit.wis.toString();
    _chaController.text = _unit.cha.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _strController.dispose();
    _dexController.dispose();
    _conController.dispose();
    _intController.dispose();
    _wisController.dispose();
    _chaController.dispose();
  }

  _setResistance(int idx) {
    setState(() {
      _unit.resistances ^= (1 << idx);
    });
  }

  bool _getResistance(int idx) {
    return (_unit.resistances & (1 << idx)) != 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        child: Column(
          children: [
            Row(children: const [
              Text(
                "Edit Unit",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ]),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
              ),
              // The validator receives the text that the user has entered.
            ),
            const SizedBox(height: 32),
            Row(
              children: const [
                Text(
                  "Stats",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Table(
                    children: [
                      TableRow(children: [
                        StatEditor(name: "STR", controller: _strController),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: StatEditor(
                              name: "DEX", controller: _dexController),
                        ),
                        StatEditor(name: "CON", controller: _conController),
                      ]),
                      const TableRow(children: [
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                      ]),
                      TableRow(children: [
                        StatEditor(name: "INT", controller: _intController),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: StatEditor(
                              name: "WIS", controller: _wisController),
                        ),
                        StatEditor(name: "CHA", controller: _chaController),
                      ])
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: const [
                Text(
                  "Resistances",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: RESISTANCES.length,
              itemBuilder: (context, i) {
                return ResistanceImmunitySwitch(
                  name: RESISTANCES[i],
                  idx: i,
                  checked: _getResistance,
                  onChanged: _setResistance,
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _unit.name = _nameController.text;
                    _unit.str = int.parse(_strController.text);
                    _unit.dex = int.parse(_dexController.text);
                    _unit.con = int.parse(_conController.text);
                    _unit.intt = int.parse(_intController.text);
                    _unit.wis = int.parse(_wisController.text);
                    _unit.cha = int.parse(_chaController.text);

                    widget.onEdit(_unit);

                    Navigator.of(context).pop();
                  },
                  child: const Text("Save"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {},
                  child: const Text("Delete"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ResistanceImmunitySwitch extends StatelessWidget {
  const ResistanceImmunitySwitch(
      {super.key,
      required this.idx,
      required this.name,
      required this.checked,
      required this.onChanged});

  final int idx;
  final Function(int) onChanged;
  final String name;
  final bool Function(int) checked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        (() {
          if (checked(idx)) {
            return TextButton(
              onPressed: () {
                onChanged(idx);
                onChanged(idx + 13);
              },
              child: const Text("50%"),
            );
          } else if (checked(idx + 13)) {
            return TextButton(
              onPressed: () {
                onChanged(idx + 13);
              },
              child: const Text("100%"),
            );
          } else {
            return TextButton(
              onPressed: () {
                onChanged(idx);
              },
              child: const Text("NONE"),
            );
          }
        }()),
      ],
    );
  }
}

class StatEditor extends StatelessWidget {
  const StatEditor({super.key, required this.name, required this.controller});

  final String name;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: name,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2)
      ],
    );
  }
}
