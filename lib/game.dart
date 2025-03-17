import 'character.dart';
import 'monster.dart';

class Game {
  Character character;
  List<Monster> monsterList = [];
  int killCount = 0;

  Game({required this.character});

  void startGame() {}

  void battle() {}

  void getRandomMonster() {}
}
