import 'package:hydrated_riverpod/hydrated_riverpod.dart';

final nameProvider =
    HydratedStateProvider((_) => "Tap to enter name", name: '_name');
final maxHealthProvider = HydratedStateProvider((_) => 0, name: '_mHP');
final curHealthProvider = HydratedStateProvider((_) => 0, name: '_cHP');
final armorClassProvider = HydratedStateProvider((_) => 0, name: '_ac');
final initiativeProvider = HydratedStateProvider((_) => 0, name: '_init');
final levelProvider = HydratedStateProvider((_) => 0, name: '_lvl');
final strengthProvider = HydratedStateProvider((_) => 0, name: '_str');
final dexterityProvider = HydratedStateProvider((_) => 0, name: '_dex');
final constitutionProvider = HydratedStateProvider((_) => 0, name: '_con');
final intelligenceProvider = HydratedStateProvider((_) => 0, name: '_int');
final wisdomProvider = HydratedStateProvider((_) => 0, name: '_wis');
final charismaProvider = HydratedStateProvider((_) => 0, name: '_cha');
final skillRollProvider = HydratedStateProvider((_) => 0, name: '_skillRoll');
final savedAttackOneProvider =
    HydratedStateProvider((_) => "No saved attack", name: "_savedAttackOne");
final savedAttackTwoProvider =
    HydratedStateProvider((_) => "No saved attack", name: "_savedAttackTwo");
final savedAttackThreeProvider =
    HydratedStateProvider((_) => "No saved attack", name: "_savedAttackThree");
