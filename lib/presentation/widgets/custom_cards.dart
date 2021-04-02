import 'package:flutter/material.dart';
import 'package:your_fav_ceo/core/config.dart';

class CustomCards extends StatelessWidget {
  final Config config;
  final ThemeData themeData;
  final double height;
  final String name;
  final int number;

  const CustomCards({
    Key key,
    @required this.config,
    @required this.themeData,
    this.height,
    @required this.name,
    @required this.number,
  })  : assert(name != null, number != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: config.width * 0.03,
      ),
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.all(config.width * 0.1),
          color: themeData.primaryColor,
          // color: Colors.white,
          height: height ?? config.height * 0.17,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: themeData.accentColor,
                    fontFamily: 'Cabin',
                    fontSize: config.width * 0.08,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  "👍 " + number.toString(),
                  style: TextStyle(
                    fontFamily: 'VarelaRound',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
