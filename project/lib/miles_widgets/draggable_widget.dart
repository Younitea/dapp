import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;

  DraggableWidget(
      {super.key, required this.child, required this.initialOffset});

  @override
  State<StatefulWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  late Offset _offset;

  @override
  void initState() {
    super.initState();
    _offset = widget.initialOffset;
  }

  void _updatePosition(DragUpdateDetails pointerMoveEvent) {
    double x = _offset.dx + pointerMoveEvent.delta.dx;
    double y = _offset.dy + pointerMoveEvent.delta.dy;

    setState(() {
      _offset = Offset(x, y);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _offset.dy,
      left: _offset.dx,
      child: GestureDetector(
        onPanUpdate: _updatePosition,
        child: widget.child,
      ),
    );
  }
}
