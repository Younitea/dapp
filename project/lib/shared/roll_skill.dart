import 'package:anydice/anydice.dart';
import 'providers.dart';

int rollSkill(String bonus, String? advordis, int stat) {
  String start = "output";
  switch (advordis![0]) {
    case 'a':
      start = "output [highest 1 of 2d20]";
      break;
    case 'd':
      start = "output [lowest 1 of 2d20]";
      break;
  }
  Future<ProbabilityDistribution> result = AnyDiceWrapper.roll(start);
  late int fin = generateRandomValue(result as ProbabilityDistribution);

  Future<ProbabilityDistribution> modifier = AnyDiceWrapper.roll(bonus);
  late int buff = generateRandomValue(modifier as ProbabilityDistribution);
  fin = fin + buff;
  return fin;
}
