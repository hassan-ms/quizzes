import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    required this.imgurl,
    required this.size,
  });

  final String imgurl;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return imgurl.isEmpty
        ? Image.asset(
            'assets/images/question.png',
            height: size.height * 0.22,
          )
        : CachedNetworkImage(
            imageUrl: imgurl,
            height: size.height * 0.22,
            placeholder: (context, url) {
              return CircularProgressIndicator();
            },
            errorWidget: (context, url, error) {
              return Image.asset(
                'assets/images/question.png',
                height: size.height * 0.22,
              );
            },
          );
  }
}
