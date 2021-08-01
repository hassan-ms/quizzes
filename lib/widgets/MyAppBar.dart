import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      // height: 50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              Text("Quiz",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              IconButton(onPressed: () {}, icon: Icon(Icons.logout))
            ],
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
