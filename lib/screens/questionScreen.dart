import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/provider/answermanager.dart';
import 'package:quiz/provider/quizmanager.dart';
import 'package:quiz/provider/resultsProvider.dart';
import 'package:quiz/widgets/MyAppBar.dart';
import 'package:quiz/widgets/question-page-widgets/imageContainer.dart';
import 'package:quiz/widgets/question-page-widgets/questionContainer.dart';

import '../constants.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _answer = -2;
  int _currentQuestionIndex = 0;
  @override
  Widget build(BuildContext context) {
    final ansmanager = Provider.of<AnswerManager>(context, listen: false);
    final size = MediaQuery.of(context).size;
    Question _question = Provider.of<Quizes>(context, listen: true)
        .getCurrentQuesstion(_currentQuestionIndex);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MyAppBar(),
            SizedBox(height: 20),
            Expanded(
                child: Provider.of<Quizes>(context, listen: false)
                        .questions
                        .isEmpty
                    ? Center(
                        child: Text('no questions found'),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuestionContainer(question: _question),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            ImageContainer(
                                imgurl: _question.imgUrl, size: size),
                            SizedBox(
                              height: size.height * 0.06,
                            ),
                            TotalChoices(
                              question: _question,
                              answer: _answer,
                              size: size,
                            ),
                            TrueOrFalse(answer: _answer, size: size),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            _answer != -2
                                ? Container()
                                : Container(
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _answer = _question.answer;
                                        });
                                        if (ansmanager.choosen ==
                                            _question.answer) {
                                          Provider.of<ResultsProvider>(context,
                                                  listen: false)
                                              .increaseDegree();
                                        }
                                        final qlength = Provider.of<Quizes>(
                                                    context,
                                                    listen: false)
                                                .questions
                                                .length -
                                            1;
                                        if (_currentQuestionIndex >= qlength) {
                                          Provider.of<ResultsProvider>(context,
                                                  listen: false)
                                              .calcPrecentage();

                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  'result-screen');
                                          return;
                                        }
                                        Future.delayed(
                                            Duration(milliseconds: 500), () {
                                          setState(() {
                                            _currentQuestionIndex++;
                                            ansmanager.changeChoosen(-1);
                                            _answer = -2;
                                          });
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(
                                              bottom: 20, right: 20),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.blue),
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            'Submit',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )),
                                    ),
                                  )
                          ],
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}

class TrueOrFalse extends StatelessWidget {
  const TrueOrFalse({
    Key? key,
    required int answer,
    required this.size,
  })  : _answer = answer,
        super(key: key);

  final int _answer;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _answer == -2
          ? Container()
          : (Provider.of<AnswerManager>(context, listen: false).choosen ==
                  _answer
              ? Image.asset(
                  'assets/images/correct.png',
                  height: size.height * 0.1,
                )
              : Image.asset(
                  'assets/images/incorrect-294245_960_720.png',
                  height: size.height * 0.1,
                )),
    );
  }
}

class TotalChoices extends StatefulWidget {
  const TotalChoices({
    required this.question,
    required this.answer,
    required this.size,
  });
  final int answer;
  final Question question;
  final Size size;

  @override
  _TotalChoicesState createState() => _TotalChoicesState();
}

class _TotalChoicesState extends State<TotalChoices> {
  // int _choosen = -1;

  @override
  Widget build(BuildContext context) {
    final ansmanager = Provider.of<AnswerManager>(context, listen: false);
    return Container(
      height: widget.size.height * 0.25,
      width: widget.size.width * 0.75,
      alignment: Alignment.center,
      child: ListView.builder(
          itemCount: widget.question.choices.length,
          itemBuilder: (_, index) => InkWell(
                child: Choice(
                  choice: widget.question.choices[index],
                  isChoosen: ansmanager.choosen == index,
                  isAnswer: widget.answer == index,
                ),
                onTap: () {
                  if (widget.answer != -2) return;
                  setState(() {
                    ansmanager.changeChoosen(index);
                  });
                },
              )),
    );
  }
}

class Choice extends StatefulWidget {
  final String choice;
  final bool isChoosen;
  final bool isAnswer;
  const Choice(
      {Key? key,
      required this.choice,
      required this.isChoosen,
      required this.isAnswer});

  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    Color _color = widget.isAnswer
        ? Colors.green
        : (widget.isChoosen ? Colors.blueGrey.shade400 : Colors.transparent);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: _color,
          border: Border.all(),
          borderRadius: BorderRadius.circular(25)),
      child:
          Text(widget.choice, style: kSubtitleTextSyule.copyWith(fontSize: 16)),
    );
  }
}
