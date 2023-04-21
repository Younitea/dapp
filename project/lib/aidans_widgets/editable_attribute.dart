import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableAttribute<T> extends ConsumerWidget {
  const EditableAttribute(
      this._provider, this._maxLen, this._width, this._attributeLabel,
      {super.key});
  final HydratedStateProvider _provider;
  final String _attributeLabel;
  final int _maxLen;
  final double _width;

  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
        width: _width,
        child: Column(
          children: [
            Text(_attributeLabel),
            EditableText(
                textAlign: TextAlign.center,
                controller: TextEditingController(
                    text: "${ref.watch(_provider.state).state}"),
                focusNode: FocusNode(),
                keyboardType: T == int ? TextInputType.number : null,
                inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(_maxLen)
                    ] +
                    (T == int ? [FilteringTextInputFormatter.digitsOnly] : []),
                style: const TextStyle(
                  color: Colors.black,
                ),
                cursorColor: Colors.black,
                backgroundCursorColor: Colors.black,
                onSubmitted: (value) => ref.read(_provider.notifier).state =
                    T == int ? int.parse(value) : value),
          ],
        ),
      );
}
