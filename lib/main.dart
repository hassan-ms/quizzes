import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/provider/answermanager.dart';
import 'package:quiz/provider/loginManager.dart';
import 'package:quiz/provider/quizmanager.dart';
import 'package:quiz/provider/resultsProvider.dart';
import 'package:quiz/screens/loginScreen.dart';
import 'package:quiz/screens/questionScreen.dart';
import 'package:quiz/screens/quizResultScreen.dart';
import 'package:quiz/screens/quizesScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LoginManager(),
        ),
        ChangeNotifierProxyProvider<LoginManager, Quizes>(
          create: (context) => Quizes(),
          update: (context, login, quizes) => quizes!..setUserId(login.userId),
        ),
        ChangeNotifierProxyProvider<Quizes, ResultsProvider>(
          create: (context) => ResultsProvider(),
          update: (context, quizes, results) => results!
            ..initiate(quizes.userId, quizes.quizId, quizes.questions.length),
        ),
        ChangeNotifierProvider.value(
          value: AnswerManager(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test',
        theme: ThemeData(
            primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
        home: LoginScreen(),
        routes: {
          'login': (ctx) => LoginScreen(),
          'question-screen': (ctx) => QuestionScreen(),
          'result-screen': (ctx) => ResultScreen(),
          'quizes-screen': (ctx) => QuizesScreen(),
        },
      ),
    );
  }
}
