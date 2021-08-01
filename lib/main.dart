import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/provider/quizmanager.dart';
import 'package:quiz/provider/subjects.dart';
import 'package:quiz/screens/loginScreen.dart';
import 'package:quiz/screens/questionScreen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:quiz/screens/subjectsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Quizes(),
        ),
        ChangeNotifierProvider.value(
          value: Subjects(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz',
        theme: ThemeData(
            primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
        home: SubjectsScreen(),
        routes: {
          'login': (ctx) => LoginScreen(),
          'question-screen': (ctx) => QuestionScreen(),
        },
      ),
    );
  }
}
