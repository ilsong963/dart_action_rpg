import 'package:dart_action_rpg/character.dart';
import 'package:dart_action_rpg/monster.dart';
import 'package:test/test.dart';

void main() {
  group("Monster 테스트", () {
    late Monster monster;

    setUp(() => monster = Monster(name: "spider", health: 10, attack: 10));

    test("attackCharacter 테스트", () {
      Character character = Character(name: "test", baseHealth: 50, baseAttack: 10, baseDefense: 10);

      monster.attackCharacter(character);
      expect(character.health > 40, isTrue);
    });
  });
}
