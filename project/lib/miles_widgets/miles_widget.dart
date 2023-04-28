import 'draggable_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class MilesWidget extends ConsumerStatefulWidget {
  const MilesWidget({super.key});
  @override
  ConsumerState<MilesWidget> createState() => _MilesWidgetState();
}

class _MilesWidgetState extends ConsumerState<MilesWidget> {
  final dragController = DragController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DraggableWidget(
          bottomMargin: 80,
          topMargin: 80,
          intialVisibility: true,
          horizontalSpace: 20,
          shadowBorderRadius: 50,
          dragController: dragController,
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
                onPressed: () {
                  Navigator.pushNamed(context, '/gm_view/camera_view');
                },
                child: const Text("Welcome to the GM View page!",
                    style: TextStyle(fontSize: 24)))),
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
    );
  }
}
