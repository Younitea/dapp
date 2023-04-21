import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../miles_widgets/miles_widget.dart';

class GmView extends ConsumerWidget {
  const GmView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => const MilesWidget();
}
