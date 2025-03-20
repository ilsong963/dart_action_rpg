import 'package:dart_action_rpg/helper.dart';
import 'package:dart_action_rpg/item.dart';
import 'package:dart_action_rpg/monster.dart';

class Character {
  String name;
  int health;
  int attack;
  int defense;
  bool isDefend = false;
  Map<Item, int> itemList = {Item.hp: 1, Item.attack: 1, Item.defense: 1};
  int baseAttack, baseDefense, baseHealth;

  Character({required this.name, required this.baseHealth, required this.baseAttack, required this.baseDefense})
    : attack = baseAttack,
      defense = baseDefense,
      health = baseHealth;

  void attackMonster(Monster monster) {
    int damage = calculateDamage(attack, monster.defense);
    monster.health -= damage;
    print("$name(이)가 ${monster.name}에게 $damage의 데미지를 입혔습니다.\n");
  }

  void defend() {
    isDefend = true;
  }

  void useItem(int index) {
    // 아이템 키를 리스트로 변환하여 인덱스로 접근
    List<Item> keys = itemList.keys.toList();

    Item item = keys[index - 1];
    itemList[item] = itemList[item]! - 1;
    if (itemList[item] == 0) {
      itemList.remove(item);
    }

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
    print("SYSTEM >> 아이템 효과 종료.");
  }

  void showStatus() {
    print("\n==============현재 상태==============");
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense');
    print("======================================\n");
  }

  void printItemList() {
    print("============== 가방 ==============");
    if (itemList.isEmpty) {
      return;
    }

    int maxNameLength = itemList.keys.fold<int>(0, (max, item) => max > item.name.length ? max : item.name.length);
    int index = 1;

    itemList.forEach((item, count) {
      print("[${index++}] ${item.name.padRight(maxNameLength + 2)} x $count   ::${item.shortExplanation}");
    });
  }

  void itemPickUp(Item item) {
    if (itemList.containsKey(item)) {
      itemList[item] = itemList[item]! + 1;
    } else {
      itemList[item] = 1;
    }
  }
}
