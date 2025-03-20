import 'dart:math';

import 'character.dart';

class Monster {
  String name;
  int health;

  int randAttackMax;
  int defense = 0;

  Monster({required this.name, required this.health, required this.randAttackMax});

  void attackCharacter(Character character) {
    int randDamage = Random().nextInt(randAttackMax + 1);
    int totalDamage = 0;

    if (character.isDefend) {
      print("${character.name}(이)가 $name의 공격을 막았습니다.\n");
      character.isDefend = false;
      return;
    }

    if (randDamage < character.defense) {
      totalDamage = character.defense;
    } else {
      totalDamage = randDamage;
    }
    character.health -= totalDamage;

    print("$name(이)가 ${character.name}에게 $totalDamage의 데미지를 입혔습니다.\n");
  }

  void showStatus() {
    print("$name - 체력 : $health , 공격력 : $randAttackMax\n");
  }

  void increaseDefense() {
    defense += 2;
  }
}
