import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableAttribute<T> extends ConsumerWidget {
  const EditableAttribute(this._provider, this._attributeLabel, {super.key});
  final String _attributeLabel;
  final HydratedStateProvider _provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVal = ref.watch(_provider.state).state;
    return Column(
      children: [
        Text(_attributeLabel),
        EditableText(
            textAlign: TextAlign.center,
            controller: TextEditingController(text: "$providerVal"),
            focusNode: FocusNode(),
            keyboardType: T == int ? TextInputType.number : null,
            inputFormatters:
                T == int ? [FilteringTextInputFormatter.digitsOnly] : null,
            style: const TextStyle(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            backgroundCursorColor: Colors.black,
            onSubmitted: (value) => ref.read(_provider.notifier).state =
                T == int ? int.parse(value) : value),
      ],
    );
  }
}
