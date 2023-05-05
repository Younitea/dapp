import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
        Text(name),
        Row(
          children: [
            Switch(value: checked(idx), onChanged: (_) => onChanged(idx)),
            Switch(
                value: checked(idx + 13), onChanged: (_) => onChanged(idx + 13))
          ],
        )
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

  final _strController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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

    _isEditing = widget.isEditing;
  }

  @override
  void dispose() {
    super.dispose();
    _strController.dispose();
  }

  _setResistance(int idx) {
    setState(() {
      _resistances ^= (1 << idx);
    });
  }

  _setImmunity(int idx) {
    _resistances ^= (1 << (13 + idx));
  }

  bool _getImmunity(int idx) {
    return (_resistances & (1 << (13 + idx))) != 0;
  }

  bool _getResistance(int idx) {
    return (_resistances & (1 << idx)) != 0;
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                ),
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
                  Expanded(
                    child: Table(
                      children: [
                        TableRow(children: [
                          StatEditor(name: "STR", controller: _strController),
                          StatEditor(name: "DEX", controller: _strController),
                          StatEditor(name: "CON", controller: _strController),
                        ]),
                        TableRow(children: [
                          StatEditor(name: "INT", controller: _strController),
                          StatEditor(name: "WIS", controller: _strController),
                          StatEditor(name: "CHA", controller: _strController),
                        ])
                      ],
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
            ],
          ),
        ),
      );
    }

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Unit Name",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                  child: const Text("Edit"),
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Attack Roll")),
              ],
            )
          ],
        ));
    // ],
    // );
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
              _unitPopupSheet(context, -1);
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
            _unitPopupSheet(context, 0);
          },
        )),
      ]),
    );
  }

  void _unitPopupSheet(BuildContext context, int id) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext ctx) {
          return DraggableScrollableSheet(
            expand: false,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(4),
                child: MonsterEditor(
                  monsterId: id,
                ),
                // child: Column(
                //   children: [
                //     Row(
                //       children: [Text("data")],
                //     )
                //   ],
                // ),
                controller: scrollController,
              );
            },
          );
        });
  }
}
