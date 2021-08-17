import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ResultsProvider with ChangeNotifier {
  static const url = "";
  List<Map<String, dynamic>> _results = [];
  List<Map<String, dynamic>> get results {
    return _results;
  }
  // void initialize() {
  //   // _questions = [];

  //   notifyListeners();
  // }
  int _quizDegree = 0;
  int get quizResult {
    return _quizDegree;
  }

  double _result = 0;
  double get result {
    return _result;
  }

  void increaseDegree() {
    _quizDegree++;
  }

  double calcPrecentage() {
    _result = (_quizDegree / questionsLength) * 100;
    checkIfResultExists();

    return _result;
  }

  int userId = 1;
  int testId = -1;
  int questionsLength = 1;
  void initiate(userId, testId, questionsLength) {
    this.testId = testId;
    this.userId = userId;
    this.questionsLength = questionsLength;

    _quizDegree = 0;
    notifyListeners();
  }

  Future<void> fetchResults() async {
    try {
      final res = await http.get(
        Uri.parse('$url/getAllUserResults/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (res.body.isEmpty) {
        _results = [];
        return;
      }
      final resBody = json.decode(res.body);

      final List<Map<String, dynamic>> results = [];
      resBody.forEach((element) {
        results.add(
            {'test_id': element['test_id'], 'result': element['test_result']});
      });
      _results = results;
    } catch (e) {
      _results = [];
    }
    notifyListeners();
  }

  Future<void> uploadResult() async {
    try {
      await http.post(Uri.parse('$url/uploadResult/$userId/$testId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(
              {'testID': testId, 'student_id': userId, 'result': _result}));
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateResult() async {
    try {
      await http.post(Uri.parse('$url/updateResult/$userId/$testId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(
              {'testID': testId, 'student_id': userId, 'result': _result}));
    } catch (e) {
      throw e;
    }
  }

  void checkIfResultExists() async {
    try {
      final res = _results.where((element) => element['test_id'] == testId);

      if (res.length == 0) {
        await uploadResult();
      } else {
        await updateResult();
      }
      _results.singleWhere(
          (element) => element['test_id'] == testId)['result'] = _result;
    } catch (e) {}
    notifyListeners();
  }
}
// /uploadResult/:userID/:testID