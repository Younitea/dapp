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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createCameraRoute());
        },
        child: const Icon(Icons.camera),
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

  void _unitPopupSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
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
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.normal),
                        ),
                        TextButton(onPressed: () {}, child: const Text("Edit"))
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Attack Roll"))
                              ],
                            )))
                  ],
                ),
              ));
        });
  }
}
