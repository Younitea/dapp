import 'package:flutter/material.dart';

import 'draggable_widget.dart';

class UnitData {
  String name;
  int hp;
  int str;
  int dex;
  int con;
  int intt;
  int wis;
  int cha;
  int resistances;

  UnitData(
      {required this.name,
      required this.hp,
      required this.str,
      required this.dex,
      required this.con,
      required this.intt,
      required this.wis,
      required this.cha,
      required this.resistances});

  UnitData.fromJson(dynamic json)
      : name = json["name"],
        hp = json["hp"],
        str = json["str"],
        dex = json["dex"],
        con = json["con"],
        intt = json["int"],
        wis = json["wis"],
        cha = json["cha"],
        resistances = json["resistances"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "hp": hp,
        "str": str,
        "dex": dex,
        "con": con,
        "int": intt,
        "wis": wis,
        "cha": cha,
        "resistances": resistances
      };
}

class UnitMarker extends StatelessWidget {
  const UnitMarker(
      {super.key,
      required this.name,
      required this.selected,
      required this.onSelect,
      required this.onPress});

  final String name;
  final bool selected;
  final Function() onSelect;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return DraggableWidget(
        initialOffset: const Offset(0, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape: CircleBorder()),
          onPressed: () => onPress(),
          onLongPress: () => onSelect(),
          child: Text(name),
        ));
  }
}
