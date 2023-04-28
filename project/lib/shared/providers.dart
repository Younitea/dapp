import 'package:hydrated_riverpod/hydrated_riverpod.dart';

import '../thomas_widgets/skill.dart';

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
/*
final skillProvider = HydratedStateProvider(
    (ref) => <Skill>[
          Skill("Acrobatics", 0, 0),
          Skill("Animal handling", 0, 0),
          Skill("Arcana", 0, 0),
          Skill("Athletics", 0, 0),
          Skill("Deception", 0, 0),
          Skill("History", 0, 0),
          Skill("Insight", 0, 0),
          Skill("Intimidation", 0, 0),
          Skill("Investigation", 0, 0),
          Skill("Medicine", 0, 0),
          Skill("Nature", 0, 0),
          Skill("Perception", 0, 0),
          Skill("Performance", 0, 0),
          Skill("Persuasion", 0, 0),
          Skill("Religon", 0, 0),
          Skill("Sleight of Hand", 0, 0),
          Skill("Stealth", 0, 0),
          Skill("Survival", 0, 0),
        ],
    name: '_skill');
*/