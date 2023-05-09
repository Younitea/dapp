import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../shared/roll_skill.dart';
import 'dice_parser.dart';

class SavedAttack extends ConsumerWidget {
  SavedAttack(this._provider, {super.key});
  final HydratedStateProvider _provider;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) => ElevatedButton(
        onPressed: () async {
          final diceStr = ref.watch(_provider.state).state;
          if (diceStr != "No saved attack") {
            final result = await rollSkill(0, "none", diceStr);
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (context) => Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text("Result: $result",
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            );
          }
        },
        onLongPress: () => showDialog(
          context: context,
          builder: (context) => Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: 200,
                height: 75,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Attack roll: "),
                    SizedBox(
                      width: 75,
                      child: TextField(
                          textAlign: TextAlign.center,
                          controller: _controller,
                          onSubmitted: (value) {
                            String newVal = ref.watch(_provider.state).state;
                            if (value == "") {
                              newVal = "No saved attack";
                            } else if (diceParser.hasMatch(value)) {
                              newVal = value;
                            } else {
                              _controller.clear();
                            }
                            ref.read(_provider.notifier).state = newVal;
                          }),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
        child: Text("${ref.watch(_provider.state).state}"),
      );
}
