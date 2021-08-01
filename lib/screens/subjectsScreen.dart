import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/subjects.dart';
import 'package:quiz/widgets/MyAppBar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quiz/widgets/course-item.dart';

import '../constants.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MyAppBar(),
            Container(
              alignment: Alignment.center,
              child: FittedBox(
                  child: Text(
                'welcome Hassan',
                style: kHeadingextStyle,
              )),
            ),
            SizedBox(height: 6),
            Container(
              alignment: Alignment.center,
              child: Text(
                'be safe be kind be smart',
                style: kSubheadingextStyle.copyWith(
                    fontSize: 15, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subjects',
                      style: kTitleTextStyle.copyWith(
                        fontSize: 22,
                      ),
                    )
                  ]),
            ),
            SizedBox(height: 25),
            Expanded(
              child: SubjectsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectsList extends StatelessWidget {
  const SubjectsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) {
        final subjects = Provider.of<Subjects>(context).subjects;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return subjects.isEmpty
            ? Center(child: Text('no subjects found'))
            : StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemBuilder: (context, index) =>
                    CourseItem(subjects[index], (index + 1) % 4),
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                itemCount: subjects.length,
              );
      },
      future: Provider.of<Subjects>(context, listen: false).fetchSubjects(),
    );
  }
}
