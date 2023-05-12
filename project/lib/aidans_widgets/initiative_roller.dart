import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/roll_skill.dart';
import '../shared/providers.dart';
import 'dice_parser.dart';

class InitiativeRoller extends ConsumerStatefulWidget {
  const InitiativeRoller({super.key});

  @override
  ConsumerState<InitiativeRoller> createState() => _InitiativeRollerState();
}

class _InitiativeRollerState extends ConsumerState<InitiativeRoller> {
  String? _dropDownValue;
  String? _bonusValue;
  Future<int> _future = Future<int>(() => 0);
  final TextEditingController _controller = TextEditingController();
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
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Bonus: "),
                                    SizedBox(
                                      width: 75,
                                      child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: _controller,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                16),
                                          ],
                                          onSubmitted: (value) {
                                            String? newVal = _bonusValue;
                                            if (value == "") {
                                              newVal = null;
                                            } else if (diceParser
                                                .hasMatch(value)) {
                                              newVal = value;
                                            } else {
                                              _controller.clear();
                                            }
                                            _bonusValue = newVal;
                                          }),
                                    ),
                                  ],
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) =>
                                      DropdownButton(
                                    value: _dropDownValue,
                                    items: const [
                                      DropdownMenuItem(
                                          value: null, child: Text("None")),
                                      DropdownMenuItem(
                                          value: "adv",
                                          child: Text("Advantage")),
                                      DropdownMenuItem(
                                          value: "dis",
                                          child: Text("Disadvantage")),
                                    ],
                                    onChanged: (value) =>
                                        setState(() => _dropDownValue = value),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        _future = rollSkill(
                                            ref
                                                .watch(dexterityProvider.state)
                                                .state,
                                            _dropDownValue,
                                            _bonusValue);
                                      });
                                      _future.then((value) => ref
                                          .read(initiativeProvider.notifier)
                                          .state = value);
                                      _bonusValue = null;
                                      _dropDownValue = null;
                                    },
                                    child: const Text("Roll!")),
                              ],
                            ),
                          ),
                        ),
                        floatingActionButton: FloatingActionButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back)),
                      ),
                    ),
                onLongPress: () =>
                    ref.read(initiativeProvider.notifier).state = 0,
                child: Text(
                    "Initiative: ${ref.watch(initiativeProvider.state).state}"));
        }
      });
}
