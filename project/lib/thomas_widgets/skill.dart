class Skill {
  String skillName;
  int bonus;
  Skill(this.skillName, this.bonus);

  Skill.fromJson(Map<String, dynamic> json)
      : skillName = json['n'],
        bonus = json['b'];

  Map<String, dynamic> toJson() {
    return {
      'n': skillName,
      'b': bonus,
    };
  }
}
