import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AttributeDisplay extends ConsumerWidget {
  const AttributeDisplay(
      {required this.provider,
      required this.attributeLabel,
      this.fontSize,
      super.key});
  final HydratedStateProvider provider;
  final String attributeLabel;
  final double? fontSize;
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      Text("$attributeLabel${ref.watch(provider.state).state}",
          style: TextStyle(fontSize: fontSize));
}
