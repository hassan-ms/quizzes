import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quiz/widgets/rounded_button.dart';
import 'package:quiz/widgets/rounded_input_field.dart';
import 'package:quiz/widgets/rounded_password_field.dart';

class LoginScreen extends StatelessWidget {
  String _username = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    final phone = "01096829698";
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          bottomSheet: Phone(phone: phone),
          body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text(
                  //   "LOGIN",
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(height: size.height * 0.03),
                  // Image.network(
                  //     "https://www.historyofthecoldwarpodcast.com/wp-content/uploads/2020/08/icon_045770_256.png",
                  //     height: size.height * 0.2,
                  //     alignment: Alignment.center, loadingBuilder:
                  //         (BuildContext context, Widget child,
                  //             ImageChunkEvent? loadingProgress) {
                  //   if (loadingProgress == null) {
                  //     return child;
                  //   }
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       value: loadingProgress.expectedTotalBytes != null
                  //           ? loadingProgress.cumulativeBytesLoaded /
                  //               loadingProgress.expectedTotalBytes!
                  //           : null,
                  //     ),
                  //   );
                  // }),
                  CachedNetworkImage(
                    imageUrl:
                        'https://www.historyofthecoldwarpodcast.com/wp-content/uploads/2020/08/icon_045770_256.png',
                    placeholder: (context, url) {
                      return CircularProgressIndicator();
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset('assets/images/MyLogo.png');
                    },
                  ),

                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "username",
                    onChanged: (value) {
                      _username = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {},
                  ),
                  SizedBox(height: size.height * 0.1),
                ],
              ),
            ),
          )),
    );
  }
}

class Phone extends StatelessWidget {
  final phone;
  const Phone({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 20, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('phone',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Flexible(
              child: Text(phone,
                  style: TextStyle(
                    // fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))
        ],
      ),
    );
  }
}
