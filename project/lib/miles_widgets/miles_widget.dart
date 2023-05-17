import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/miles_widgets/aoe_attack_widget.dart';
import 'package:project/miles_widgets/camera_view.dart';
import 'package:project/miles_widgets/unit_display.dart';
import 'package:project/miles_widgets/unit_editor.dart';
import 'package:project/thomas_widgets/thomas_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'draggable_widget.dart';
import 'unit_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class MilesWidget extends ConsumerStatefulWidget {
  const MilesWidget({super.key});
  @override
  ConsumerState<MilesWidget> createState() => _MilesWidgetState();
}

class _MilesWidgetState extends ConsumerState<MilesWidget> {
  List<UnitData> _units = [];
  List<int> _selected = [];

  Route _createCameraRoute() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const CameraView(),
    );
  }

  Directory? appDir;

  @override
  void initState() {
    super.initState();

    _loadState();

    getApplicationDocumentsDirectory().then((dir) {
      setState(() {
        appDir = dir;
      });
    });
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final units = prefs.getStringList("units");
    if (units != null) {
      setState(() {
        _units =
            units.map((unit) => UnitData.fromJson(jsonDecode(unit))).toList();
      });
    }
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        "units", _units.map((unit) => jsonEncode(unit.toJson())).toList());
  }

  @override
  Widget build(BuildContext context) {
    if (appDir == null) return const SizedBox();

    _saveState();

    File imageFile = File("${appDir!.path}/image.png");

    List<Widget> floatingDoodads = _units.asMap().entries.map<Widget>((entry) {
      var idx = entry.key;

      return UnitMarker(
        name: entry.value.name,
        selected: _selected.contains(idx),
        initialOffset: _units[idx].offset,
        onDrag: (offset) {
          setState(() {
            _units[idx].offset = offset;
          });
        },
        onSelect: () {
          setState(() {
            if (_selected.contains(idx)) {
              _selected.remove(idx);
            } else {
              _selected.add(idx);
            }
          });
        },
        onPress: () {
          _unitPopupSheet(context, idx);
        },
      );
    }).toList();

    if (!imageFile.existsSync()) {
      floatingDoodads.insert(
        0,
        const SizedBox(
          width: 1024.0,
          height: 1024.0,
        ),
      );
    } else {
      floatingDoodads.insert(
        0,
        Image.file(
          imageFile,
          height: 1024.0,
          width: 1024.0,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("GM View"),
      ),
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: [
          FloatingActionButton(
            heroTag: "attack_button",
            onPressed: () {
              if (_selected.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'You need to select some units in order to execute an attack.'),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AoeAttackDialog(
                      units: _units,
                      selected: _selected,
                      onRollComplete: (newUnits) {
                        setState(() {
                          _selected = [];
                          _units = newUnits;
                        });
                      },
                    );
                  },
                );
              }
            },
            child: const Icon(Icons.local_fire_department),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            heroTag: "camera_button",
            onPressed: () {
              Navigator.of(context)
                  .push(_createCameraRoute())
                  .whenComplete(() => setState(() {}));
            },
            child: const Icon(Icons.add_a_photo),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            heroTag: "add_button",
            onPressed: () {
              _unitPopupSheet(context, _units.length);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          InteractiveViewer(
            maxScale: 8,
            minScale: 0.25,
            scaleEnabled: true,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            constrained: false,
            child: Stack(
              children: floatingDoodads,
            ),
          ),
        ],
      ),
    );
  }

  void _unitPopupSheet(BuildContext context, int id) {
    UnitData? unit;

    if (id >= 0 && id < _units.length) {
      unit = _units.elementAt(id);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.7,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(4),
              controller: scrollController,
              child: UnitViewerAndEditor(
                unitData: unit,
                onEdit: (newUnit) {
                  setState(() {
                    if (id < _units.length) {
                      _units[id] = newUnit;
                      _units.length;
                    } else {
                      _units.add(newUnit);
                    }
                  });
                },
                onDelete: () {
                  setState(() {
                    _units.removeAt(id);
                  });
                },
              ),
            );
          },
        );
      },
    );
  }
}

class UnitViewerAndEditor extends StatefulWidget {
  final UnitData? unitData;
  final Function(UnitData) onEdit;
  final Function() onDelete;

  const UnitViewerAndEditor(
      {super.key,
      required this.unitData,
      required this.onEdit,
      required this.onDelete});

  @override
  State<StatefulWidget> createState() => _UnitViewerAndEditorState();
}

class _UnitViewerAndEditorState extends State<UnitViewerAndEditor> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    if (_isEditing || widget.unitData == null) {
      return UnitEditor(
          unitData: widget.unitData,
          onEdit: widget.onEdit,
          onDelete: widget.onDelete);
    } else {
      return UnitDisplay(
        unitData: widget.unitData!,
        startEditing: () {
          setState(() {
            _isEditing = true;
          });
        },
      );
    }
  }
}
