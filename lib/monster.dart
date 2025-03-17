import 'character.dart';

class Monster {
  String name;
  int health;

  int randAttackMax;
  int defense = 0;

  Monster(this.name, this.health, this.randAttackMax);

  void attackCharacter(Character character) {}
  void showStatus() {}
}
