import 'dart:math';

import 'character.dart';
import 'monster.dart';
import 'dart:io';

class Game {
  late Character character;
  List<Monster> monsterList = [];
  int killCount = 0;

  void startGame() {
    print("게임을 시작합니다!");
    _initData();
    character.showStatus();

    while (monsterList.isNotEmpty) {
      print("새로운 몬스터가 나타났습니다!");
      Monster monster = getRandomMonster();
      monster.showStatus();

      battle(monster);

      if (character.health <= 0) {
        print("게임 오버! 패배했습니다.");
        askSaveResult(false);
        break;
      }

      if (monsterList.isEmpty) {
        print("축하합니다! 모든 몬스터를 물리쳤습니다.");
        askSaveResult(true);
      } else if (_askLoop(
            question: "다음 몬스터와 싸우시겠습니까? (y/n)",
            error: "다시 입력해주세요",
            answer1: 'y',
            answer2: 'n',
          ) ==
          'n') {
        askSaveResult(false);
        break;
      }
    }

    print("게임을 종료합니다.");
  }

  void _initData() {
    loadCharacterStats();
    loadMonsterStats();
  }

  void battle(Monster monster) {
    while (character.health > 0 && monster.health > 0) {
      print("몬스터 체력: ${monster.health}, 내 체력: ${character.health}");

      // 플레이어 턴
      print("${character.name}의 턴");
      String action = _askLoop(
        question: "행동을 선택하세요 (1: 공격, 2:방어): ",
        error: "다시 입력해주세요",
        answer1: '1',
        answer2: '2',
      );
      action == '1' ? character.attackMonster(monster) : character.defend();

      if (monster.health <= 0) {
        print("${monster.name}을(를) 물리쳤습니다!");
        killCount++;
        break;
      }

      // 몬스터 턴
      print("${monster.name}의 턴");
      monster.attackCharacter(character);
    }
  }

  dynamic _askLoop({
    required String question,
    required String error,
    required dynamic answer1,
    required dynamic answer2,
  }) {
    String? answer;

    while (true) {
      print(question);
      answer = stdin.readLineSync();

      if (answer != null && (answer == answer1 || answer == answer2)) {
        return answer;
      }
      if (answer != null) {
        print(error);
      }
    }
  }

  Monster getRandomMonster() {
    int rand = Random().nextInt(monsterList.length);
    Monster monster = monsterList[rand];
    monsterList.removeAt(rand);
    return monster;
  }

  String getCharacterName() {
    print("캐릭터의 이름을 입력하세요:");
    String? name;
    RegExp regex = RegExp(r'^[a-zA-Z가-힣]+$');

    while (true) {
      name = stdin.readLineSync();

      if (name != null && regex.hasMatch(name)) {
        return name;
      }
      if (name != null) {
        print("특수문자나 숫자가 포함되어 있습니다. 이름을 다시 입력해주세요.");
      }
    }
  }

  void loadCharacterStats() {
    try {
      final file = File('./lib/characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 3) throw FormatException('Invalid character data');

      int health = int.parse(stats[0]);
      int attack = int.parse(stats[1]);
      int defense = int.parse(stats[2]);

      String name = getCharacterName();
      character = Character(
        name: name,
        health: health,
        attack: attack,
        defense: defense,
      );
    } catch (e) {
      print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  void loadMonsterStats() {
    try {
      final file = File('./lib/monsters.txt');
      final lines = file.readAsLinesSync();
      for (var line in lines) {
        final stats = line.split(',');
        if (stats.length != 3) throw FormatException('Invalid monster data');

        String name = stats[0];
        int health = int.parse(stats[1]);
        int randAttackMax = int.parse(stats[2]);
        monsterList.add(
          Monster(name: name, health: health, randAttackMax: randAttackMax),
        );
      }
    } catch (e) {
      print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  void gameOver(bool isWin) {
    print('결과를 저장하시겠습니까? (y/n)');
    String? answer;

    while (answer == null || answer == 'y' || answer == 'n') {
      try {
        answer = stdin.readLineSync();
      } catch (e) {
        print("다시 입력해주세요");
      }
    }

    if (answer == 'y') {
      saveResult(isWin);
    }
  }

  void askSaveResult(bool result) {
    String answer = _askLoop(
      question: "결과를 저장하시겠습니까? (y/n)",
      error: "다시 입력해주세요",
      answer1: "y",
      answer2: "n",
    );
    if (answer == "y") {
      saveResult(result);
    }
  }

  void saveResult(bool isWin) {
    final file = File('result.txt');

    try {
      file.writeAsStringSync(
        "${character.name},${character.health}, ${isWin ? "승리" : "패배"}",
      ); // 파일이 없으면 자동 생성
      print('저장되었습니다.');
    } catch (e) {
      print('파일 저장 중 오류가 발생했습니다: $e');
    }
  }
}
