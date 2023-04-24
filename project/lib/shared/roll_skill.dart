import 'package:anydice/anydice.dart';

int rollSkill(String bonus, String? advordis, bool prof, bool exp, int stat) {
  //need to get level
  const level = 10;
  int proff = ((level / 4).ceil() + 1);
  int stat = 0;
  String start = "output";
  switch (advordis![0]) {
    case 'a':
      start = "output [highest 1 of 2d20]";
      break;
    case 'd':
      start = "output [lowest 1 of 2d20]";
      break;
  }
  switch (stat) {
    case 0:
    //stat = str provider
    case 1:
    //stat = dex
    case 2:
    //stat = con
    case 3:
    //stat = int
    case 4:
    //stat = wis
    case 5:
    //stat = cha
  }
  Future<ProbabilityDistribution> result = AnyDiceWrapper.roll(start);
  late int fin = generateRandomValue(result as ProbabilityDistribution);
  if (prof) {
    fin = fin + proff;
    if (exp) {
      fin = fin + proff;
    }
  }

  Future<ProbabilityDistribution> modifier = AnyDiceWrapper.roll(bonus);
  late int buff = generateRandomValue(modifier as ProbabilityDistribution);
  fin = fin + buff;
  return fin;
}
