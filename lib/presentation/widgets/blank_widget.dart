import 'package:flutter/material.dart';
import '../../core/config.dart';

class BlankCardWidget extends StatelessWidget {
  final Config config;

  const BlankCardWidget({Key key, @required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(config.width * 0.1))),
      child: Container(
        width: config.width * 0.7,
        height: config.height * 0.6,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(config.width * 0.1))),
        alignment: Alignment.center,
        child: Text(
          'VOTED\n All\n CEOS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: config.height * 0.04,
            fontWeight: FontWeight.w700,
            fontFamily: 'Cabin',
          ),
        ),
      ),
    );
  }
}
