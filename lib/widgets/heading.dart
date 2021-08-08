import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.37,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: FittedBox(
                child: Text(
              'welcome',
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
            height: size.height * 0.01,
          ),
          CachedNetworkImage(
            imageUrl: '',
            height: size.height * 0.2,
            placeholder: (context, url) {
              return CircularProgressIndicator();
            },
            errorWidget: (context, url, error) {
              return Image.asset(
                'assets/images/MyLogo.png',
                height: size.height * 0.2,
              );
            },
          ),
        ],
      ),
    );
  }
}
