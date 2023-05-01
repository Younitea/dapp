import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AttributeDisplay extends ConsumerWidget {
  const AttributeDisplay(
      {required this.provider,
      required this.width,
      required this.attributeLabel,
      this.fontSize,
      super.key});
  final HydratedStateProvider provider;
  final String attributeLabel;
  final double? fontSize;
  final double width;
  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
        width: width,
        child: Text("$attributeLabel${ref.watch(provider.state).state}",
            style: TextStyle(fontSize: fontSize)),
      );
}
