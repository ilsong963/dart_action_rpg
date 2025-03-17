import 'dart:math';

import 'character.dart';

class Monster {
  String name;
  int health;

  int randAttackMax;
  int defense = 0;

  Monster({required this.name, required this.health, required this.randAttackMax});

  void attackCharacter(Character character) {
    int randDamge = Random().nextInt(randAttackMax + 1);

    if (randDamge < character.defense) {
      character.health -= character.defense;
    } else {
      character.health -= randDamge;
    }
  }

  void showStatus() {
    print("$name - 체력 : $health , 공격력 : $randAttackMax ");
  }
}
