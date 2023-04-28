class Skill {
  String skillName;
  int bonus;
  int stat;
  Skill(this.skillName, this.bonus, this.stat);

  Skill.fromJson(Map<String, dynamic> json)
      : skillName = json['n'],
        bonus = json['b'],
        stat = json['s'];

  Map<String, dynamic> toJson() {
    return {
      'n': skillName,
      'b': bonus,
      's': stat,
    };
  }
}
