import 'package:hydrated_riverpod/hydrated_riverpod.dart';

import 'thomas_widgets/skill.dart';

final nameProvider =
    HydratedStateProvider((_) => "Tap to enter name", name: '_playerName');

final healthProvider = HydratedStateProvider((_) => 0, name: '_health');

final skillProvider = HydratedStateProvider<List<Skill>>(
    (ref) => (<Skill>[
          Skill("Acrobatics", false, false, 0),
          Skill("Animal handling", false, false, 0),
          Skill("Arcana", false, false, 0),
          Skill("Athletics", false, false, 0),
          Skill("Deception", false, false, 0),
          Skill("History", false, false, 0),
          Skill("Insight", false, false, 0),
          Skill("Intimidation", false, false, 0),
          Skill("Investigation", false, false, 0),
          Skill("Medicine", false, false, 0),
          Skill("Nature", false, false, 0),
          Skill("Perception", false, false, 0),
          Skill("Performance", false, false, 0),
          Skill("Persuasion", false, false, 0),
          Skill("Religon", false, false, 0),
          Skill("Sleight of Hand", false, false, 0),
          Skill("Stealth", false, false, 0),
          Skill("Survival", false, false, 0),
        ]),
    name: '_skill');
