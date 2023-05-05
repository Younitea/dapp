import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../shared/roll_skill.dart';

class SavedAttack extends ConsumerWidget {
  const SavedAttack(this._provider, {super.key});
  final HydratedStateProvider _provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ElevatedButton(
        onPressed: () async {
          final result =
              await rollSkill(0, "none", ref.watch(_provider.state).state);
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) => Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  width: 100,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text("Result: $result"),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back),
              ),
            ),
          );
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
                        onSubmitted: (value) =>
                            ref.read(_provider.notifier).state = value,
                      ),
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
