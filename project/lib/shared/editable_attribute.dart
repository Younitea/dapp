import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableAttribute extends ConsumerWidget {
  const EditableAttribute(
      {super.key,
      required this.provider,
      required this.maxLen,
      required this.width,
      this.height,
      this.fontSize,
      this.attributeLabel});
  final HydratedStateProvider provider;
  final int maxLen;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? attributeLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
        width: width,
        height: height,
        child: TextField(
          textInputAction: TextInputAction.go,
          controller:
              TextEditingController(text: "${ref.watch(provider.state).state}"),
          focusNode: FocusNode(),
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLen),
            FilteringTextInputFormatter.digitsOnly
          ],
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: attributeLabel,
          ),
          cursorColor: Colors.black,
          onSubmitted: (value) =>
              ref.read(provider.notifier).state = int.tryParse(value) ?? 0,
        ),
      );
}
