import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

class Quizes with ChangeNotifier {
  List<Question> _questions = [
    Question(
        questiontxt: 'what is the capital of Egypt ?',
        choices: ['tokyo', 'cairo', 'alexandria'],
        imgUrl:
            "https://www.surveylegend.com/wordpress/wp-content/uploads/2020/12/best-open-ended-questions.png",
        answer: 1),
    Question(
        questiontxt: 'how many continents in the world ?',
        choices: ['5', '6', '7'],
        answer: 2),
    Question(
        questiontxt: 'which of this is the largest continent ?',
        choices: ['Asia', 'Africa', 'North America'],
        answer: 0),
  ];

  List<Question> get questions {
    return _questions;
  }

  Question getCurrentQuesstion(questionIndex) {
    return _questions[questionIndex];
  }

  int _quizDegree = 0;
  int get quizResult {
    return _quizDegree;
  }

  void increaseDegree() {
    _quizDegree++;
  }

  double calcPrecentage() {
    return (_quizDegree / questions.length) * 100;
  }
}
