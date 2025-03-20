import 'dart:math';

import 'package:dart_action_rpg/helper.dart';

import 'character.dart';

class Monster {
  String name;
  int health;

  int attack;
  int defense = 0;

  Monster({required this.name, required this.health, required this.attack});

  void attackCharacter(Character character) {
    if (character.isDefend) {
      print("${character.name}(이)가 $name의 공격을 막았습니다.\n");
      character.isDefend = false;
      return;
    } else {
      int damage = calculateDamage(attack, character.defense);

      character.health = max(0, character.health - damage);

      print("$name(이)가 ${character.name}에게 $damage 데미지를 입혔습니다.\n");
    }
  }

  void showStatus() {
    print("$name - 체력 : $health , 공격력 : $attack\n");
  }

  void increaseDefense() {
    defense += 2;
  }
}
