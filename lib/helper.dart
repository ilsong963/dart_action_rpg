import 'dart:io';
import 'dart:math';

dynamic askLoop({required String question, required String error, required List<String> validAnswers}) {
  String? answer;

  while (true) {
    print(question);
    answer = stdin.readLineSync();

    if (answer != null && validAnswers.contains(answer)) {
      return answer;
    }
    if (answer != null) {
      print(error);
    }
  }
}

int calculateDamage(int attackPower, int defense) {
  int variance = Random().nextInt((attackPower * 0.2).toInt() + 1); // 공격력의 최대 20% 변동
  int damage = max(1, attackPower - defense + variance);
  return damage;
}
