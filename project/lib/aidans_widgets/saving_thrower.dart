import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../shared/roll_skill.dart';
import '../shared/providers.dart';

class SavingThrower extends ConsumerStatefulWidget {
  const SavingThrower({super.key});

  @override
  ConsumerState<SavingThrower> createState() => _SavingThrowerState();
}

class _SavingThrowerState extends ConsumerState<SavingThrower> {
  String? _dropDownValue;
  int? _bonusValue;
  Future<int> _future = Future<int>(() => 0);

  @override
  Widget build(context) => FutureBuilder(
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
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Bonus: "),
                              SizedBox(
                                width: 25,
                                child: TextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    onSubmitted: (value) =>
                                        _bonusValue = int.tryParse(value)),
                              ),
                            ],
                          ),
                          StatefulBuilder(
                            builder: (context, setState) => DropdownButton(
                              value: _dropDownValue,
                              items: const [
                                DropdownMenuItem(
                                    value: "str", child: Text("Strength")),
                                DropdownMenuItem(
                                    value: "dex", child: Text("Dexterity")),
                                DropdownMenuItem(
                                    value: "con", child: Text("Constitution")),
                                DropdownMenuItem(
                                    value: "int", child: Text("Intelligence")),
                                DropdownMenuItem(
                                    value: "wis", child: Text("Wisdom")),
                                DropdownMenuItem(
                                    value: "cha", child: Text("Charisma")),
                              ],
                              onChanged: (value) =>
                                  setState(() => _dropDownValue = value),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                if (_dropDownValue == null) return;
                                int result = 0;
                                switch (_dropDownValue) {
                                  case "str":
                                    result =
                                        ref.watch(strengthProvider.state).state;
                                    break;
                                  case "dex":
                                    result = ref
                                        .watch(dexterityProvider.state)
                                        .state;
                                    break;
                                  case "con":
                                    result = ref
                                        .watch(constitutionProvider.state)
                                        .state;
                                    break;
                                  case "int":
                                    result = ref
                                        .watch(intelligenceProvider.state)
                                        .state;
                                    break;
                                  case "wis":
                                    result =
                                        ref.watch(wisdomProvider.state).state;
                                    break;
                                  case "cha":
                                    result =
                                        ref.watch(charismaProvider.state).state;
                                    break;
                                }
                                setState(() {
                                  _future = rollSkill();
                                });
                                _future.then((value) => showDialog(
                                      context: this.context,
                                      builder: (context) => Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: Center(
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                  "Result: ${(_bonusValue ?? 0) + (result / 2).floor() - 5 + value}",
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                            ),
                                          ),
                                        ),
                                        floatingActionButton:
                                            FloatingActionButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Icon(Icons.arrow_back),
                                        ),
                                      ),
                                    ));
                                setState(() {
                                  _bonusValue = null;
                                  _dropDownValue = null;
                                });
                              },
                              child: const Text("Roll!")),
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
              child: const Text("Saving Throw"),
            );
        }
      });
}
