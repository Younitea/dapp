import 'package:flutter/material.dart';

class FillableColoredCircle extends StatelessWidget {
  const FillableColoredCircle(this._color, this._curRolls, this._threshold,
      {super.key});
  final Color _color;
  final int _curRolls;
  final int _threshold;
  @override
  Widget build(BuildContext context) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _curRolls < _threshold ? null : _color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _color,
            width: 2,
          ),
        ),
      );
}
