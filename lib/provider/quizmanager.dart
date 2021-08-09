import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/models/quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Quizes with ChangeNotifier {
  int userId = -1;
  void setUserId(userId) {
    this.userId = userId;
    notifyListeners();
  }

  static const url = "https://hostforexaa.glitch.me";
  static const List<String> choices = ['A', 'B', 'C', 'D'];
  List<Question> _questions = [];

  List<Question> get questions {
    return _questions;
  }

  Question getCurrentQuesstion(questionIndex) {
    return _questions[questionIndex];
  }

  int _quizId = -1;

  get quizId {
    return _quizId;
  }

  List<Quiz> _quizes = [];
  Future<void> fetchQuizes() async {
    try {
      final res = await http.get(
        Uri.parse('$url/getUserTests/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (res.body.isEmpty) {
        return;
      }
      final List<Quiz> quizes = [];
      final resBody = json.decode(res.body);
      resBody.forEach((element) {
        quizes.add(Quiz(id: element['id'], name: element['name']));
      });
      _quizes = quizes;
    } catch (e) {}
    notifyListeners();
  }

  List<Quiz> get quizes {
    return _quizes;
  }

  Future<int> fetchQuestions(quizId) async {
    _quizId = quizId;
    try {
      final res = await http.get(
        Uri.parse('$url/getQuestions/$quizId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (res.body.isEmpty) {
        return 0;
      }
      final resBody = json.decode(res.body);
      final List<Question> resultQuestions = [];

      resBody.forEach((element) {
        resultQuestions.add(Question(
            id: element['id'],
            imgUrl: element['image'],
            questiontxt: element['question'],
            choices: element['D'].isEmpty
                ? [element['A'], element['B'], element['C']]
                : [element['A'], element['B'], element['C'], element['D']],
            answer: choices.indexOf(element['Answer'])));
      });
      _questions = resultQuestions;
    } catch (e) {}
    notifyListeners();
    return _questions.length;
  }
}
// getAllUserResults/:id
// getUserResult/:userID/:testID
