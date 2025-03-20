import 'package:dart_action_rpg/item.dart';
import 'package:dart_action_rpg/monster.dart';

class Character {
  String name;
  int health;
  int attack;
  int defense;
  bool isDefend = false;
  bool hasItem = true;
  List<Item> itemList = [Item.hp, Item.attack, Item.defense];
  int baseAttack, baseDefense, baseHealth;

  Character({required this.name, required this.baseHealth, required this.baseAttack, required this.baseDefense})
    : attack = baseAttack,
      defense = baseDefense,
      health = baseHealth;

  void attackMonster(Monster monster) {
    print("$name(이)가 ${monster.name}에게 $attack의 데미지를 입혔습니다.\n");
    monster.health -= attack;
  }

  void defend() {
    isDefend = true;
  }

  void useItem(int index) {
    Item item = itemList.removeAt(index - 1);

    switch (item) {
      case Item.hp:
        health *= 2;
        break;
      case Item.attack:
        attack *= 2;
        break;
      case Item.defense:
        defense *= 2;
        break;
    }
  }

  void resetStats() {
    attack = baseAttack;
    defense = baseDefense;
    health = baseHealth;
    print("아이템 효과 종료.");
  }

  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense\n');
  }

  void printItemList() {
    int maxNameLength = itemList.map((item) => item.name.length).reduce((a, b) => a > b ? a : b);

    print("============== 가방 ==============");
    for (var i = 0; i < itemList.length; i++) {
      print("[${i + 1}] ${itemList[i].name.padRight(maxNameLength + 2)} :: ${itemList[i].explanation}");
    }
  }
}
