import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class CourseItem extends StatelessWidget {
  final course;
  final index;
  const CourseItem(
    this.course,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(94, 98, 172, 1);
    Color textColor = Colors.white;
    String svgUrl = 'assets/images/grad.svg';
    // int x=index%4;
    if (index == 3) {
      color = Color.fromRGBO(26, 184, 254, 1);
    } else if (index == 0 || index == 2) {
      color = Colors.white;
      textColor = Colors.black;
      svgUrl = 'assets/images/undraw_education_f8ru.svg';
    }
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey, width: 0.3),
          color: color,
        ),
        height: index.isEven ? 200 : 230,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              child: Opacity(
                  opacity: 0.8,
                  child: SvgPicture.asset(
                    svgUrl,
                    width: index.isEven ? 150 : 190,
                  )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      course.name,
                      style: kTitleTextStyle.copyWith(color: textColor),
                    )),
              ],
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
