import 'package:flutter/material.dart';

import '../../core/config.dart';
import '../../core/constants.dart';

class CustomCards extends StatelessWidget {
  final Config config;
  // final ThemeData themeData;
  final double height;
  final String name;
  final int number;
  final bool flex;

  const CustomCards({
    Key key,
    @required this.config,
    // @required this.themeData,
    this.height,
    @required this.name,
    @required this.number,
    this.flex = false,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(config.height * 0.01),
          ),
        ),
        child: Container(
          padding: !flex
              ? EdgeInsets.all(config.width * 0.1)
              : EdgeInsets.only(left: config.width * 0.1),
          decoration: BoxDecoration(
            color: greyishWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(config.height * 0.01),
            ),
          ),
          // color: Colors.white,
          height: height ?? config.height * 0.17,
          child: Row(
            children: [
              Flexible(
                  child: Text(
                name,
                overflow: TextOverflow.fade,
                style: _buildTextStyle(),
              )),
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

  TextStyle _buildTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontFamily: 'Cabin',
      fontSize: config.width * 0.08,
      letterSpacing: 1.3,
      fontWeight: FontWeight.bold,
    );
  }
}
