import 'package:flutter/material.dart';
import '../constants.dart';

class ListTitle extends StatelessWidget {
  final title;
  const ListTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: kTitleTextStyle.copyWith(
          fontSize: 25,
        ),
      ),
    );
  }
}
