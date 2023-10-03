import 'package:quiz_app/classes/question.dart';

class Quiz {
  String name;
  List<Question> questions;
  int right = 0;

  Quiz({required this.name, required this.questions});  // Constructor

  double get percent => (right / questions.length) * 100;
}