import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';
import 'package:flutter/material.dart';

class ShareOnbordingScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  const ShareOnbordingScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUrl, width: 300, fit: BoxFit.cover),
        SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: kBlack.withOpacity(.75),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.all(KDefaltPadding),
          child: Text(
            description,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kGrey,
            ),
          ),
        ),
      ],
    );
  }
}
