import 'package:dart_action_rpg/item.dart';
import 'package:dart_action_rpg/monster.dart';

class Character {
  String name;
  int health;
  int attack;
  int defense;
  bool isDefend = false;
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
        health += item.value;
        print("체력을 ${item.value} 회복했습니다");
        break;
      case Item.attack:
        attack += item.value;
        print("공격력이 ${item.value} 증가 했습니다");
        break;
      case Item.defense:
        defense += item.value;
        print("방어력이 ${item.value} 증가 했습니다");
        break;
    }
    showStatus();
  }

  void resetStats() {
    attack = baseAttack;
    defense = baseDefense;
    print("아이템 효과 종료.");
  }

  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense\n');
  }

  void printItemList() {
    int maxNameLength = itemList.fold<int>(0, (max, item) => max > item.name.length ? max : item.name.length);

    print("============== 가방 ==============");
    for (var i = 0; i < itemList.length; i++) {
      print("[${i + 1}] ${itemList[i].name.padRight(maxNameLength + 2)} :: ${itemList[i].shortExplanation}");
    }
  }
}
