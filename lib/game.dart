import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:dart_action_rpg/helper.dart';
import 'package:dart_action_rpg/item.dart';
import 'character.dart';
import 'monster.dart';

class Game {
  late Character character;
  List<Monster> monsterList = [];

  Future<void> delayedPrint(String message, {int milliseconds = 1000}) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
    print(message);
  }

  bool canLoadData(String name) {
    try {
      Map<String, dynamic> map = loadTxt('./lib/data/result.txt');
      return map['character']['name'] == name && !(map['isClear'] as bool);
    } catch (e) {
      return false;
    }
  }

  Future<void> startGame() async {
    await _initData();
    await printStart();
    await randomEffect();

    while (true) {
      character.showStatus();
      await delayedPrint("SYSTEM >> 새로운 몬스터가 나타났습니다!");
      Monster monster = _getRandomMonster();
      monster.showStatus();

      await _battle(monster);

      if (character.health <= 0) {
        await delayedPrint("SYSTEM >> 게임 오버! 패배했습니다.");
        if (canLoadData(character.name)) {
          if (askLoadPreviousData()) {
            continue;
          } else {
            break;
          }
        }
      }

      if (monsterList.isEmpty) {
        await delayedPrint("SYSTEM >> 축하합니다! 모든 몬스터를 물리쳤습니다.");
        await _askSaveResult(true);
        break;
      }

      await _askSaveResult(false);
    }

    await delayedPrint("SYSTEM >> 게임을 종료합니다.");
  }

  Future<void> _initData() async {
    String name = _getCharacterName();
    if (canLoadData(name) && askLoadPreviousData()) {
      return;
    } else {
      _loadCharacterStats(name);
      _loadMonsterStats();
    }
  }

  Future<void> printStart() async {
    await delayedPrint("\n======================================");
    await delayedPrint("★ ☆ ★ ☆ 게임을 시작합니다 ★ ☆ ★ ☆");
    await delayedPrint("======================================\n");
  }

  Future<void> _battle(Monster monster) async {
    bool isItemUsed = false;
    int turn = 0;
    while (character.health > 0 && monster.health > 0) {
      turn += 1;
      await delayedPrint("SYSTEM >> ${character.name}의 턴");

      while (true) {
        String action = askLoop(
          question: "SYSTEM >> 행동을 선택하세요 (1: 공격, 2: 방어, 3: 가방): ",
          error: "SYSTEM >> 다시 입력해주세요",
          validAnswers: ['1', '2', '3'],
        );

        switch (action) {
          case '1':
            character.attackMonster(monster);
            break;
          case '2':
            character.defend();
            break;
          case '3':
            character.printItemList();
            print('[0] 닫기');
            String itemChoice = askLoop(
              question: "SYSTEM >> 행동을 선택하세요",
              error: "SYSTEM >> 다시 입력해주세요",
              validAnswers: List.generate(character.itemList.length + 1, (index) => (index).toString()),
            );
            if (itemChoice != '0') {
              character.useItem(int.parse(itemChoice));
              isItemUsed = true;
            }
            continue;
        }
        break;
      }

      if (isItemUsed) {
        character.resetStats();
        isItemUsed = false;
      }

      if (monster.health <= 0) {
        await delayedPrint("SYSTEM >> ${monster.name}을(를) 물리쳤습니다!\n");
        if (monsterList.length != 1) {
          await randomDrop();
        }
        break;
      }

      await delayedPrint("SYSTEM >> ${monster.name}의 턴");
      monster.attackCharacter(character);

      if (turn % 3 == 0) {
        monster.increaseDefense();
        await delayedPrint('SYSTEM >> ${monster.name}의 방어력이 증가했습니다! 현재 방어력: ${monster.defense}');
      }

      character.showStatus();
      monster.showStatus();
    }
  }

  Monster _getRandomMonster() {
    int rand = Random().nextInt(monsterList.length);
    Monster monster = monsterList[rand];
    monsterList.removeAt(rand);
    return monster;
  }

  String _getCharacterName() {
    print("SYSTEM >> 캐릭터의 이름을 입력하세요:");
    String? name;
    RegExp regex = RegExp(r'^[a-zA-Z가-힣]+$');

    while (true) {
      name = stdin.readLineSync();

      if (name != null && regex.hasMatch(name)) {
        return name;
      }
      if (name != null) {
        print("SYSTEM >> 특수문자나 숫자가 포함되어 있습니다. 이름을 다시 입력해주세요.");
      }
    }
  }

  Map<String, dynamic> loadTxt(String path) {
    String jsonString = File(path).readAsStringSync();
    return jsonDecode(jsonString);
  }

  void loadPreviousData() {
    Map<String, dynamic> jsonData = loadTxt('./lib/data/result.txt');
    character = Character.fromJson(jsonData['character']);
    monsterList = (jsonData['monsters'] as List).map((monsterJson) => Monster.fromJson(monsterJson)).toList();
  }

  bool askLoadPreviousData() {
    String answer = askLoop(question: "SYSTEM >> 이전 데이터를 불러오겠습니까? (y/n)", error: "SYSTEM >> 다시 입력해주세요", validAnswers: ['y', 'n']);
    if (answer == "y") {
      loadPreviousData();
      print("SYSTEM >> 이전 데이터를 불러옵니다");
      return true;
    }
    return false;
  }

  void _loadCharacterStats(String name) {
    try {
      final file = File('./lib/data/characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 3) throw FormatException('Invalid character data');

      int health = int.parse(stats[0]);
      int attack = int.parse(stats[1]);
      int defense = int.parse(stats[2]);

      character = Character(name: name, baseHealth: health, baseAttack: attack, baseDefense: defense);
    } catch (e) {
      print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    }
  }

  void _loadMonsterStats() {
    try {
      final file = File('./lib/data/monsters.txt');
      final lines = file.readAsLinesSync();
      for (var line in lines) {
        final stats = line.split(',');
        if (stats.length != 3) throw FormatException('Invalid monster data');

        String name = stats[0];
        int health = int.parse(stats[1]);
        int randAttackMax = int.parse(stats[2]);
        monsterList.add(Monster(name: name, health: health, attack: randAttackMax));
      }
    } catch (e) {
      print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    }
  }

  Future<void> _askSaveResult(bool isClear) async {
    String answer = askLoop(question: "SYSTEM >> 결과를 저장하시겠습니까? (y/n)", error: "SYSTEM >> 다시 입력해주세요", validAnswers: ['y', 'n']);
    if (answer == "y") {
      await _saveResult(isClear);
    }
  }

  Future<void> _saveResult(bool isClear) async {
    final file = File('./lib/data/result.txt');
    try {
      String jsonString = jsonEncode({
        "character": character.toJson(),
        "monsters": monsterList.map((monster) => monster.toJson()).toList(),
        "isClear": isClear,
      });
      file.writeAsStringSync(jsonString);
      await delayedPrint('SYSTEM >> 저장되었습니다.');
    } catch (e) {
      print('파일 저장 중 오류가 발생했습니다: $e');
    }
  }

  Future<void> randomEffect() async {
    if (Random().nextDouble() < 0.3) {
      character.health += 10;
      await delayedPrint("SYSTEM >> 보너스 체력을 얻었습니다! 현재 체력: ${character.health}");
    }
  }

  Future<void> randomDrop() async {
    if (Random().nextDouble() < 0.5) {
      Item randomAction = Item.values[Random().nextInt(Item.values.length)];
      character.itemPickUp(randomAction);
      await delayedPrint("SYSTEM >> 아이템을 얻었습니다! : ${randomAction.name}\n");
    }
  }
}
