import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/quizmanager.dart';
import 'package:quiz/widgets/MyAppBar.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static var chartDisplay;
  @override
  Widget build(BuildContext context) {
    final res =
        Provider.of<Quizes>(context, listen: false).calcPrecentage().toInt();
    var data = [
      addcharts('5', res, charts.Color(r: 228, g: 18, b: 29)),
      addcharts('0', 100 - res, charts.Color(r: 255, g: 255, b: 255, a: 0))
    ];

    var series = [
      charts.Series(
          domainFn: (addcharts add, _) => add.label,
          measureFn: (addcharts add, _) => add.value,
          data: data,
          id: 'ss',
          colorFn: (addcharts add, _) => add.cl)
    ];
    chartDisplay = charts.PieChart(series,
        animationDuration: Duration(milliseconds: 1000),
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 30,
            startAngle: 4 / 5 * 22 / 7,
            arcLength: 7 / 5 * 22 / 7));
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          MyAppBar(),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Result',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 400,
            width: 400,
            child: chartDisplay,
          ),
          Container(
            child: Text(
              '$res %',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ));
  }
}

class addcharts {
  final String label;
  final int value;
  // final Color color;
  final charts.Color cl;
  addcharts(this.label, this.value, this.cl);
}
