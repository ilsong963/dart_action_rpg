import 'package:dart_action_rpg/character.dart';
import 'package:dart_action_rpg/item.dart';
import 'package:dart_action_rpg/monster.dart';
import 'package:test/test.dart';

void main() {
  late Character character;
  group("Character 테스트", () {
    setUp(() => character = Character(name: "test", baseHealth: 100, baseAttack: 10, baseDefense: 10));

    test("attackMonster 테스트", () {
      Monster monster = Monster(name: 'testMonster', health: 10, attack: 10);
      character.attackMonster(monster);

      expect(monster.health, 0);
    });

    test("useItem 선택한 아이템이 삭제되는지 테스트", () {
      character.itemList = [Item.hp, Item.attack, Item.defense];

      character.useItem(2);

      expect(character.itemList, [Item.hp, Item.defense]);
    });

    test("useItem 선택한 아이템효과 테스트", () {
      character.itemList = [Item.hp, Item.attack, Item.defense];

      character.useItem(1);

      expect(character.health, 120);

      character.useItem(1);

      expect(character.attack, 20);
      character.useItem(1);

      expect(character.defense, 20);
    });

    test("resetStats 아이템 효과 초기화", () {
      character.itemList = [Item.hp, Item.attack, Item.defense];

      character.useItem(1);
      character.resetStats();
      expect(character.health, 120);
      character.useItem(1);
      character.resetStats();
      expect(character.attack, 10);
      character.useItem(1);
      character.resetStats();
      expect(character.defense, 10);
    });
  });
}
