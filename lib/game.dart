import 'character.dart';
import 'monster.dart';
import 'dart:io';

class Game {
  Character character;
  List<Monster> monsterList = [];
  int killCount = 0;

  Game({required this.character});

  void startGame() {}

  void battle() {}

  void getRandomMonster() {}

  String getCharacterName(){
print("캐릭터의 이름을 입력하세요:");

      return stdin.readLineSync()!; // !를 통해 null이 아님을 보장
  
  }

 


  void loadCharacterStats() {
  try {
    final file = File('characters.txt');
    final contents = file.readAsStringSync();
    final stats = contents.split(',');
    if (stats.length != 3) throw FormatException('Invalid character data');
      
    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);
      
    String name = getCharacterName();
    character = Character(name: name, health:health, attack:attack, defense:defense);
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

// 위 함수와 마찬가지로 몬스터들의 스탯을 불러오는 함수도 작성해보세요.
void loadMonsterStats() {
  ...
}
}
