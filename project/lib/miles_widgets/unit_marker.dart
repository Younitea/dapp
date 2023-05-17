import 'package:flutter/material.dart';

import 'draggable_widget.dart';

class UnitData {
  String name;
  Offset offset;
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
      required this.offset,
      required this.hp,
      required this.str,
      required this.dex,
      required this.con,
      required this.intt,
      required this.wis,
      required this.cha,
      required this.resistances});

  void setResistance(int idx) {
    resistances ^= (1 << idx);
  }

  bool getResistance(int idx) {
    return (resistances & (1 << idx)) != 0;
  }

  UnitData.fromJson(dynamic json)
      : name = json["name"],
        offset = Offset(json["x"], json["y"]),
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
        "x": offset.dx,
        "y": offset.dy,
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
      required this.initialOffset,
      required this.onDrag,
      required this.selected,
      required this.onSelect,
      required this.onPress});

  final Offset initialOffset;
  final String name;
  final bool selected;
  final Function(Offset) onDrag;
  final Function() onSelect;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    var color;
    if (selected) {
      color = Colors.red;
    } else {
      color = Colors.blue;
    }

    return DraggableWidget(
        initialOffset: initialOffset,
        onDrag: onDrag,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: color,
          ),
          onPressed: () => onPress(),
          onLongPress: () => onSelect(),
          child: Text(name),
        ));
  }
}
