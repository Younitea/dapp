import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AttributeDisplay extends ConsumerWidget {
  const AttributeDisplay(
      {required this.provider,
      required this.attributeLabel,
      this.fontSize,
      this.width,
      this.height,
      super.key});
  final HydratedStateProvider provider;
  final String attributeLabel;
  final double? fontSize;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
        width: width,
        height: height,
        child: TextField(
          readOnly: true,
          controller:
              TextEditingController(text: "${ref.watch(provider.state).state}"),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: attributeLabel,
          ),
          style: TextStyle(fontSize: fontSize),
        ),
      );
}
