import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/quiz.dart';
import 'package:quiz/provider/quizmanager.dart';
import 'package:quiz/provider/resultsProvider.dart';
import '../constants.dart';

class QuizesList extends StatelessWidget {
  const QuizesList({
    Key? key,
  }) : super(key: key);
  Future<void> fetch(ctx) async {
    Provider.of<Quizes>(ctx, listen: false).fetchQuizes();
    Provider.of<ResultsProvider>(ctx, listen: false).fetchResults();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetch(context),
      builder: (ctx, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: Consumer<Quizes>(
                    builder: (ctx, quizes, _) => quizes.quizes.isEmpty
                        ? Center(
                            child: Text('no tests found',
                                style: TextStyle(
                                  fontSize: 18,
                                )))
                        : ListView.builder(
                            itemBuilder: (ctx, index) {
                              // return Container();
                              // final quizes =
                              //     Provider.of<Quizes>(context, listen: false).quizes;
                              return QuizItem(quiz: quizes.quizes[index]);
                            },
                            itemCount:
                                Provider.of<Quizes>(context, listen: false)
                                    .quizes
                                    .length,
                          )),
                onRefresh: () => fetch(ctx),
              );
        ;
      },
    );
  }
}

class QuizItem extends StatefulWidget {
  const QuizItem({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final Quiz quiz;

  @override
  _QuizItemState createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_isLoading) {
          return;
        }
        setState(() {
          _isLoading = true;
        });
        final qlength = await Provider.of<Quizes>(context, listen: false)
            .fetchQuestions(widget.quiz.id);
        if (qlength <= 0) {
          setState(() {
            _isLoading = false;
          });
          return;
        }

        setState(() {
          _isLoading = false;
        });
        Navigator.of(context)
            .pushNamed('question-screen', arguments: widget.quiz.id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/testIcon.png',
                height: 40,
              ),
              Container(
                height: 40,
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  width: 30,
                ),
              ),
              Text(
                widget.quiz.name,
                style: kTitleTextStyle,
              ),
              SizedBox(
                width: 50,
              ),
              Consumer<ResultsProvider>(builder: (ctx, results, _) {
                final result = results.results
                    .where((element) => element['test_id'] == widget.quiz.id);
                return result.length == 0
                    ? Container()
                    : result.first['result'] >= 50
                        ? Text('Pass',
                            style: kTitleTextStyle.copyWith(
                                color: Colors.green, fontSize: 18))
                        : Text('Failed',
                            style: kTitleTextStyle.copyWith(
                                color: Colors.red, fontSize: 18));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
