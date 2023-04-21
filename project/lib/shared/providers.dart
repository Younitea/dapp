import 'package:hydrated_riverpod/hydrated_riverpod.dart';

final nameProvider =
    HydratedStateProvider((_) => "Tap to enter name", name: '_playerName');

final maxHealthProvider = HydratedStateProvider((_) => 0, name: '_mHealth');
final curHealthProvider = HydratedStateProvider((_) => 0, name: '_cHealth');
final armorClassProvider = HydratedStateProvider((_) => 0, name: '_armorClass');
final initiativeProvider = HydratedStateProvider((_) => 0, name: '_initiative');
