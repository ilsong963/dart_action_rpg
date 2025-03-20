enum Item {
  hp('HP_UP', '체력 회복', "체력을 20 회복합니다.", 10),
  attack('ATTACK_UP', '공격력 증가', "한 턴동안 공격력이 두배로 증가합니다.", 10),
  defense('DEFENSE_UP', '방어력 증가', "한 턴동안 방어력이 두배로 증가합니다.", 10);

  const Item(this.name, this.shortExplanation, this.longExplanation, this.value);
  final String name;
  final String shortExplanation;
  final String longExplanation;
  final int value;
}
