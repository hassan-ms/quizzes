import 'package:flutter/cupertino.dart';

class Subject {
  final name;
  Subject(this.name);
}

class Subjects with ChangeNotifier {
  List<Subject> _subjects = [
    Subject('math'),
    Subject('geography'),
    Subject('physics'),
    Subject('physics'),
  ];
  List<Subject> get subjects {
    return _subjects;
  }

  Future<void> fetchSubjects() {
    return Future.delayed(Duration.zero);
  }
}
