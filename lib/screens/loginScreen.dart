import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/loginManager.dart';
import 'package:quiz/provider/screeninfo.dart';
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
  bool _displayLogo = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await Provider.of<Information>(context, listen: false).fetchInfo();
      final res =
          await Provider.of<LoginManager>(context, listen: false).smothLogin();
      if (res > 0) {
        Navigator.of(context).pushReplacementNamed('quizes-screen');
      } else {
        setState(() {
          _displayLogo = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List info = Provider.of<Information>(context).info;
    final phone = info[1];
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
                  SizedBox(
                    height: 10,
                  ),
                  CachedNetworkImage(
                    height: size.height * 0.20,
                    imageUrl: info[0],
                    maxWidthDiskCache: (size.width * 0.5).toInt(),
                    placeholder: (context, url) {
                      return CircularProgressIndicator();
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        'assets/images/asfalt-light.png',
                        height: size.height * 0.20,
                      );
                    },
                  ),
                  _displayLogo
                      ? Container()
                      : Column(
                          children: [
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
                                      if (_username.length < 5 ||
                                          _password.length < 5) {
                                        setState(() {
                                          _errmessage =
                                              "Incorrect username and/or password";
                                        });
                                        return;
                                      }
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final res =
                                          await Provider.of<LoginManager>(
                                                  context,
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
                                            .pushReplacementNamed(
                                                'quizes-screen');
                                      }
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    },
                                    text: "LOGIN",
                                  ),
                            SizedBox(height: size.height * 0.1),
                          ],
                        )
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
