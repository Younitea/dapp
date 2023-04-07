import 'package:hydrated_riverpod/hydrated_riverpod.dart';

final nameProvider =
    HydratedStateProvider((_) => "Tap to enter name", name: '_playerName');

final healthProvider = HydratedStateProvider((_) => 0, name: '_health');
