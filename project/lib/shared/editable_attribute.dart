import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableAttribute<T> extends ConsumerWidget {
  const EditableAttribute(
      {super.key,
      required this.provider,
      required this.maxLen,
      this.fontSize,
      this.attributeLabel,
      this.maxLines,
      this.alignment = TextAlign.start});
  final HydratedStateProvider provider;
  final int maxLen;
  final double? fontSize;
  final String? attributeLabel;
  final TextAlign alignment;
  final int? maxLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
        children: [
          if (attributeLabel != null)
            Text(
              attributeLabel!,
              style: TextStyle(fontSize: fontSize),
            ),
          Flexible(
            child: EditableText(
              minLines: 1,
              maxLines: maxLines ?? 1,
              textAlign: alignment,
              textInputAction: TextInputAction.go,
              controller: TextEditingController(
                  text: "${ref.watch(provider.state).state}"),
              focusNode: FocusNode(),
              keyboardType:
                  T == int ? TextInputType.number : TextInputType.name,
              inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(maxLen)
                  ] +
                  (T == int ? [FilteringTextInputFormatter.digitsOnly] : []),
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
              ),
              cursorColor: Colors.black,
              backgroundCursorColor: Colors.black,
              onSubmitted: (value) => ref.read(provider.notifier).state =
                  T == int ? int.parse(value) : value,
            ),
          ),
        ],
      );
}
