import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../shared/roll_skill.dart';
import '../shared/providers.dart';

class InitiativeRoller extends ConsumerStatefulWidget {
  const InitiativeRoller({super.key});

  @override
  ConsumerState<InitiativeRoller> createState() => _InitiativeRollerState();
}

class _InitiativeRollerState extends ConsumerState<InitiativeRoller> {
  String? _dropDownValue;
  String? _bonusValue;
  @override
  Widget build(BuildContext context) => ElevatedButton(
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
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                              onSubmitted: (value) =>
                                  _bonusValue = value != "" ? value : null,
                            ),
                          ),
                        ],
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => DropdownButton(
                          value: _dropDownValue,
                          items: const [
                            DropdownMenuItem(value: null, child: Text("None")),
                            DropdownMenuItem(
                                value: "adv", child: Text("Advantage")),
                            DropdownMenuItem(
                                value: "dis", child: Text("Disadvantage")),
                          ],
                          onChanged: (value) =>
                              setState(() => _dropDownValue = value),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            ref.read(initiativeProvider.notifier).state =
                                await rollSkill(
                                    ref.watch(dexterityProvider.state).state,
                                    _dropDownValue,
                                    _bonusValue);
                            _bonusValue = null;
                            _dropDownValue = null;
                            Navigator.pop(context);
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
      onLongPress: () => ref.read(initiativeProvider.notifier).state = 0,
      child: Text("Initiative: ${ref.watch(initiativeProvider.state).state}"));
}
