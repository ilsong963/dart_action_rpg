import 'dart:io';

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
