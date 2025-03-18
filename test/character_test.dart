import 'package:dart_action_rpg/character.dart';
import 'package:dart_action_rpg/monster.dart';
import 'package:test/test.dart';

void main() {
  late Character character;
  group("Character 테스트", () {
    setUp(() => character = Character(name: "test", health: 100, attack: 10, defense: 10));

    test("attackMonster 테스트", () {
      Monster monster = Monster(name: 'testMonster', health: 10, randAttackMax: 10);
      character.attackMonster(monster);

      expect(monster.health, 0);
    });
  });
}
