import 'package:dart_action_rpg/game.dart';
import 'package:dart_action_rpg/monster.dart';
import 'package:test/test.dart';

void main() {
  late Game game;

  group("game 테스트", () {
    setUp(() => game = Game());

    // test("loadMonsterStats 테스트", () {
    //   game.loadMonsterStats();

    //   expect(game.monsterList[0].name, 'Batman');

    //   expect(game.monsterList[0].health, 30);

    //   expect(game.monsterList[0].randAttackMax, 20);
    // });
    // test("getRandomMonster 테스트", () {
    //   game.monsterList = [
    //     Monster(name: 'test1', health: 10, randAttackMax: 10),
    //     Monster(name: 'test2', health: 20, randAttackMax: 20),
    //     Monster(name: 'test3', health: 30, randAttackMax: 30),
    //   ];

    //   final randomMonster = game.getRandomMonster();
    //   expect(game.getRandomMonster(), isA<Monster>());
    //   expect(game.monsterList.contains(randomMonster), isTrue);
    // });
  });
}
