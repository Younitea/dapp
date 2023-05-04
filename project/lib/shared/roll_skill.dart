import 'package:anydice/anydice.dart';

Future<int> rollSkill([int stat = 0, String? advordis, String? bonus]) async {
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
  return stat +
      generateRandomValue(await AnyDiceWrapper.roll(start)) +
      generateRandomValue(await AnyDiceWrapper.roll(bonus));
}
