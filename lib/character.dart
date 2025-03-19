import 'package:dart_action_rpg/monster.dart';

class Character {
  String name;
  int health;
  int attack;
  int defense;
  bool isDefend = false;

  Character({
    required this.name,
    required this.health,
    required this.attack,
    required this.defense,
  });

  void attackMonster(Monster monster) {
    print("$name(이)가 ${monster.name}에게 $attack의 데미지를 입혔습니다");
    monster.health -= attack;
  }

  void defend() {
    isDefend = true;
  }

  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}
