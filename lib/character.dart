import 'package:dart_action_rpg/monster.dart';

class Character {
  String name;
  int health;
  int attack;
  int defense;

  Character({required this.name, required this.health, required this.attack, required this.defense});

  void attackMonster(Monster monster) {
    monster.health -= attack;
  }

  void defend() {}
  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}
