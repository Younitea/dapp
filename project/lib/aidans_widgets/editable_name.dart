import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/providers.dart';

class EditableName extends ConsumerWidget {
  const EditableName(this._maxLen, this._fontSize, {super.key});
  final int _maxLen;
  final double _fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) => EditableText(
        minLines: 1,
        maxLines: 2,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.go,
        controller: TextEditingController(
          text: ref.watch(nameProvider.state).state,
        ),
        focusNode: FocusNode(),
        keyboardType: TextInputType.name,
        inputFormatters: [LengthLimitingTextInputFormatter(_maxLen)],
        style: TextStyle(
          color: Colors.black,
          fontSize: _fontSize,
        ),
        cursorColor: Colors.black,
        backgroundCursorColor: Colors.black,
        onSubmitted: (value) => ref.read(nameProvider.notifier).state = value,
      );
}
