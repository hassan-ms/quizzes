import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/loginManager.dart';
import 'package:quiz/widgets/rounded_button.dart';
import 'package:quiz/widgets/rounded_input_field.dart';
import 'package:quiz/widgets/rounded_password_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";

  String _password = "";

  String _errmessage = "";
  bool _isLoading = false;

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
                    height: size.height * 0.25,
                    imageUrl:
                        'https://www.historyofthecoldwarpodcast.com/wp-content/uploads/2020/08/icon_045770_256.png',
                    placeholder: (context, url) {
                      return CircularProgressIndicator();
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        'assets/images/MyLogo.png',
                        height: size.height * 0.25,
                      );
                    },
                  ),

                  SizedBox(height: size.height * 0.03),
                  Text(
                    _errmessage,
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                  SizedBox(height: size.height * 0.01),
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
                  SizedBox(height: 10),
                  _isLoading
                      ? CircularProgressIndicator()
                      : RoundedButton(
                          press: () async {
                            if (_username.length < 5 || _password.length < 5) {
                              setState(() {
                                _errmessage =
                                    "Incorrect username and/or password";
                              });
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                            });
                            final res = await Provider.of<LoginManager>(context,
                                    listen: false)
                                .login(_username, _password);
                            if (res == -1) {
                              setState(() {
                                _errmessage =
                                    "Incorrect username and/or password";
                              });
                            } else if (res == -5) {
                              setState(() {
                                _errmessage =
                                    "please check your network and try again";
                              });
                            } else if (res >= 0) {
                              Navigator.of(context)
                                  .pushReplacementNamed('quizes-screen');
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          text: "LOGIN",
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
