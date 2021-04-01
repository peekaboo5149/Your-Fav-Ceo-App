import 'package:flutter/material.dart';
import 'package:your_fav_ceo/core/config.dart';

class CustomCards extends StatelessWidget {
  final Config config;
  final ThemeData themeData;
  final double height;

  const CustomCards(
      {Key key, @required this.config, @required this.themeData, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: config.width * 0.03,
      ),
      child: Card(
        elevation: 5.0,
        child: Container(
          color: themeData.primaryColor,
          height: height ?? config.height * 0.17,
        ),
      ),
    );
  }
}
