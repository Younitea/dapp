class Skill {
  String skillName = '';
  int bonus = 0;
  int stat = 0;
  Skill(this.skillName, this.bonus, this.stat);

  Skill.fromJson(Map<String, dynamic> json)
      : skillName = json['n'],
        bonus = json['b'],
        stat = json['s'];

  Map<String, dynamic> toJson() {
    return {
      'n': skillName,
      'b': stat,
      's': stat,
    };
  }
}
