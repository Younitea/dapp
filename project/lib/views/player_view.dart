import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../thomas_widgets/thomas_widget.dart';
import '../aidans_widgets/aidans_widget.dart';

class PlayerView extends ConsumerWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: const Text("Player View"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                AidansWidget(),
                ThomasWidget(),
              ],
            ),
          ),
        ),
      );
}
