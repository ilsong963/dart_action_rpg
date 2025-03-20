import 'dart:io';

dynamic askLoop({required String question, required String error, required dynamic answer1, required dynamic answer2, dynamic answer3, dynamic answer4}) {
  String? answer;

  while (true) {
    print(question);
    answer = stdin.readLineSync();

    if (answer != null && (answer == answer1 || answer == answer2 || answer == answer3 || answer == answer4)) {
      return answer;
    }
    if (answer != null) {
      print(error);
    }
  }
}
