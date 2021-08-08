import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';

import '../../constants.dart';

class QuestionContainer extends StatelessWidget {
  const QuestionContainer({
    Key? key,
    required Question question,
  })  : _question = question,
        super(key: key);

  final Question _question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        _question.questiontxt,
        style: kTitleTextStyle.copyWith(fontSize: 22),
        textAlign: TextAlign.center,
      ),
    );
  }
}
