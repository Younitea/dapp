import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AttributeDisplay extends ConsumerWidget {
  const AttributeDisplay(this._provider, this._width, this._attributeLabel,
      {super.key});
  final HydratedStateProvider _provider;
  final String _attributeLabel;
  final double _width;
  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
        width: _width,
        child: Column(
          children: [
            Text(_attributeLabel),
            Text("${ref.watch(_provider.state).state}"),
          ],
        ),
      );
}
