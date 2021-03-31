import 'package:flutter/material.dart';
import 'package:your_fav_ceo/core/config.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    @required this.config,
    @required this.theme,
    @required this.text,
  }) : super(key: key);

  final Config config;
  final ThemeData theme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: config.height * 0.1,
      left: config.width * 0.04,
      right: config.width * 0.04,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: config.height * 0.01,
        ),
        width: config.width,
        height: config.height * 0.5,
        child: Text(
          text,
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: config.width * 0.1,
          ),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: theme.accentColor,
            borderRadius:
                BorderRadius.all(Radius.circular(config.width * 0.1))),
      ),
    );
  }
}
