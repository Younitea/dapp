import 'draggable_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class MilesWidget extends ConsumerStatefulWidget {
  const MilesWidget({super.key});
  @override
  ConsumerState<MilesWidget> createState() => _MilesWidgetState();
}

class _MilesWidgetState extends ConsumerState<MilesWidget> {
  final _dragController = DragController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GM View"),
      ),
      body: Column(children: [
        DraggableWidget(
          bottomMargin: 80,
          topMargin: 80,
          intialVisibility: true,
          horizontalSpace: 20,
          shadowBorderRadius: 50,
          dragController: _dragController,
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
        ),
        Center(
            child: ElevatedButton(
          child: const Text("test popup"),
          onPressed: () {
            _unitPopupSheet(context);
          },
        )),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/camera_view');
                },
                child: const Text("Welcome to the GM View page!",
                    style: TextStyle(fontSize: 24)))),
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
                padding: EdgeInsets.all(8.0),
                child: Text("data"),
              ));
        });
  }
}
