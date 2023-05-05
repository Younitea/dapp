import 'package:flutter/rendering.dart';
import 'package:project/miles_widgets/camera_view.dart';

import 'draggable_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class StatDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(children: [
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("STR: 69", style: TextStyle(fontSize: 20.0))),
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("DEX: 69", style: TextStyle(fontSize: 20.0))),
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("CON: 69", style: TextStyle(fontSize: 20.0))),
        ]),
        TableRow(children: [
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("INT: 69", style: TextStyle(fontSize: 20.0))),
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("WIS: 69", style: TextStyle(fontSize: 20.0))),
          Padding(
              padding: EdgeInsets.all(6.0),
              child: Text("CHA: 69", style: TextStyle(fontSize: 20.0))),
        ]),
      ],
    );
  }
}

class ResistanceSwitch extends StatelessWidget {
  const ResistanceSwitch(
      {super.key,
      required this.name,
      required this.checked,
      required this.onChanged});

  final Function(bool) onChanged;
  final String name;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(name), Switch(value: checked, onChanged: onChanged)],
    );
  }
}

class MonsterEditor extends ConsumerStatefulWidget {
  const MonsterEditor(
      {super.key, required this.monsterId, this.isEditing = false});

  final int monsterId;
  final bool isEditing;

  @override
  _MonsterViewState createState() => _MonsterViewState();
}

class _MonsterViewState extends ConsumerState<MonsterEditor> {
  bool _isEditing = false;
  int _resistances = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _isEditing = widget.isEditing;
  }

  _setResistance(int idx) {
    setState(() {
      _resistances ^= (1 << idx);
    });
  }

  bool _getResistance(int idx) {
    return (_resistances & (1 << idx)) != 0;
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                child: Column(children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Name"),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Stats:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Resistances:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ResistanceSwitch(
                  name: "Acid",
                  checked: _getResistance(0),
                  onChanged: (_) => _setResistance(0)),
              ResistanceSwitch(
                  name: "Cold",
                  checked: _getResistance(1),
                  onChanged: (_) => _setResistance(1)),
              ResistanceSwitch(
                  name: "Fire",
                  checked: _getResistance(2),
                  onChanged: (_) => _setResistance(2)),
              ResistanceSwitch(
                  name: "Force",
                  checked: _getResistance(3),
                  onChanged: (_) => _setResistance(3)),
              ResistanceSwitch(
                  name: "Lightning",
                  checked: _getResistance(4),
                  onChanged: (_) => _setResistance(4)),
              ResistanceSwitch(
                  name: "Necrotic",
                  checked: _getResistance(5),
                  onChanged: (_) => _setResistance(5)),
              ResistanceSwitch(
                  name: "Poison",
                  checked: _getResistance(6),
                  onChanged: (_) => _setResistance(6)),
              ResistanceSwitch(
                  name: "Psychic",
                  checked: _getResistance(7),
                  onChanged: (_) => _setResistance(7)),
              ResistanceSwitch(
                  name: "Radiant",
                  checked: _getResistance(8),
                  onChanged: (_) => _setResistance(8)),
              ResistanceSwitch(
                  name: "Thunder",
                  checked: _getResistance(9),
                  onChanged: (_) => _setResistance(9)),
              ResistanceSwitch(
                  name: "Bludgeoning",
                  checked: _getResistance(10),
                  onChanged: (_) => _setResistance(10)),
              ResistanceSwitch(
                  name: "Slashing",
                  checked: _getResistance(11),
                  onChanged: (_) => _setResistance(11)),
              ResistanceSwitch(
                  name: "Piercing",
                  checked: _getResistance(12),
                  onChanged: (_) => _setResistance(12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Save")),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.red)),
                      onPressed: () {},
                      child: Text("Delete"))
                ],
              )
            ])),
          )));
    }

    return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monster Name",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      child: const Text("Edit"))
                ],
              ),
              const SizedBox(height: 10),
              Row(children: [HPDisplay()]),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: StatDisplay()))
                ],
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () {}, child: Text("Attack Roll")),
              ))
            ],
          ),
        ));
  }
}

class HPDisplay extends StatelessWidget {
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
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ))
            ],
          )),
      Text("HP: 45/100",
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold))
    ]));
  }
}

class MilesWidget extends ConsumerStatefulWidget {
  const MilesWidget({super.key});
  @override
  ConsumerState<MilesWidget> createState() => _MilesWidgetState();
}

class _MilesWidgetState extends ConsumerState<MilesWidget> {
  final _dragController = DragController();

  Route _createCameraRoute() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const CameraView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GM View"),
      ),
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(_createCameraRoute());
            },
            child: const Icon(Icons.add_a_photo),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: () {
              _newUnitPopupSheet(context);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(children: [
        Center(
            child: ElevatedButton(
          child: const Text("test popup"),
          onPressed: () {
            _unitPopupSheet(context);
          },
        )),
      ]),
    );
  }

  void _newUnitPopupSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return MonsterEditor(
            monsterId: -1,
          );
        });
  }

  void _unitPopupSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return MonsterEditor(monsterId: 0);
        });
  }
}
