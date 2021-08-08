import 'package:flutter/material.dart';

import 'package:quiz/widgets/MyAppBar.dart';
import 'package:quiz/widgets/heading.dart';
import 'package:quiz/widgets/quizesList.dart';
import '../widgets/title.dart';

class QuizesScreen extends StatelessWidget {
  const QuizesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MyAppBar(),
            Heading(size: size),
            ListTitle(title: "Tests"),
            Expanded(child: QuizesList())
          ],
        ),
      ),
    );
  }
}
