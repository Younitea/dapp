import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/providers.dart';

class HealthModifier extends ConsumerWidget {
  const HealthModifier(this._label, this._buttonColor, this._subtract,
      {super.key});
  final String _label;
  final bool _subtract;
  final Color _buttonColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _buttonColor,
        fixedSize: const Size.fromWidth(90),
      ),
      onPressed: () => showDialog(
            context: context,
            builder: (context) => Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  width: 150,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Enter Amount:"),
                      SizedBox(
                        width: 75,
                        child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onSubmitted: (value) {
                              ref.read(curHealthProvider.notifier).state +=
                                  ((int.tryParse(value) ?? 0) *
                                      (_subtract ? -1 : 1));
                              ref.read(curHealthProvider.notifier).state = ref
                                  .watch(curHealthProvider.state)
                                  .state
                                  .clamp(0, 999);
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back)),
            ),
          ),
      child: Text(_label));
}
