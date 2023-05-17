import 'package:project/miles_widgets/unit_attack_widget.dart';

import 'unit_marker.dart';
import 'package:flutter/material.dart';

class UnitDisplay extends StatelessWidget {
  UnitDisplay({super.key, required this.unitData, required this.startEditing});

  UnitData unitData;
  Function() startEditing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                unitData.name,
                style: const TextStyle(
                    fontSize: 32, fontWeight: FontWeight.normal),
              ),
              TextButton(
                onPressed: startEditing,
                child: const Text("Edit"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(children: [HPDisplay(hp: unitData.hp)]),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: StatDisplay(unitData: unitData),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return UnitAttackDialog();
                    },
                  );
                },
                child: const Text("Attack Roll"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HPDisplay extends StatelessWidget {
  HPDisplay({super.key, required this.hp});

  final int hp;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(alignment: Alignment.center, children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
            )
          ],
        ),
      ),
      Text(
        "HP: $hp",
        style: TextStyle(
            color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
      )
    ]));
  }
}

class StatDisplay extends StatelessWidget {
  StatDisplay({super.key, required this.unitData});

  UnitData unitData;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(children: [
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("STR: ${unitData.str}",
                  style: const TextStyle(fontSize: 20.0))),
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("DEX: ${unitData.dex}",
                  style: TextStyle(fontSize: 20.0))),
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("CON: ${unitData.con}",
                  style: TextStyle(fontSize: 20.0))),
        ]),
        TableRow(children: [
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("INT: ${unitData.intt}",
                  style: TextStyle(fontSize: 20.0))),
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("WIS: ${unitData.wis}",
                  style: TextStyle(fontSize: 20.0))),
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("CHA: ${unitData.cha}",
                  style: TextStyle(fontSize: 20.0))),
        ]),
      ],
    );
  }
}
