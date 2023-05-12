import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/roll_skill.dart';
import 'dice_parser.dart';

class SavedAttack extends ConsumerStatefulWidget {
  const SavedAttack(this._provider, {super.key});
  final HydratedStateProvider _provider;

  @override
  ConsumerState<SavedAttack> createState() => _SavedAttackState(_provider);
}

class _SavedAttackState extends ConsumerState<SavedAttack> {
  _SavedAttackState(this._provider);
  final HydratedStateProvider _provider;
  final TextEditingController _controller = TextEditingController();
  Future<int> _future = Future<int>(() => 0);
  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(),
            );
          default:
            return ElevatedButton(
              onPressed: () {
                final diceStr = ref.watch(_provider.state).state;
                if (diceStr != "No saved attack") {
                  setState(() {
                    _future = rollSkill(0, "none", diceStr);
                  });
                  _future.then(
                    (value) => showDialog(
                      context: context,
                      builder: (context) => Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text("Result: $value",
                                  style: const TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                        floatingActionButton: FloatingActionButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back),
                        ),
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
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(16),
                                ],
                                onSubmitted: (value) {
                                  bool shouldClose = true;
                                  String newVal =
                                      ref.watch(_provider.state).state;
                                  if (value == "") {
                                    newVal = "No saved attack";
                                  } else if (diceParser.hasMatch(value)) {
                                    newVal = value;
                                  } else {
                                    shouldClose = false;
                                    _controller.clear();
                                  }
                                  ref.read(_provider.notifier).state = newVal;
                                  if (shouldClose) {
                                    Navigator.pop(context);
                                  }
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
      });
}
