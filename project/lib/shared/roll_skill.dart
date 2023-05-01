import 'package:anydice/anydice.dart';

Future<int> rollSkill(int stat, String? advordis, String? bonus) async {
  String start = "output";
  bonus = "output ${bonus ?? "0"}";
  switch (advordis) {
    case 'adv':
      start += " [highest 1 of 2d20]";
      break;
    case 'dis':
      start += " [lowest 1 of 2d20]";
      break;
    case null:
      start += " 1d20";
      break;
  }
  return generateRandomValue(await AnyDiceWrapper.roll(start)) +
      stat +
      generateRandomValue(await AnyDiceWrapper.roll(bonus));
}
