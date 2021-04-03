import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/config.dart';
import '../../core/constants.dart';

class CustomMaterialButton extends StatelessWidget {
  final Config config;
  final VoidCallback onTap;
  final Color color;
  final String logoasset;
  final String title;
  final double padding;
  final bool canSubmit;
  final bool isLoading;
  final ThemeData themeData;

  const CustomMaterialButton(
      {Key key,
      this.config,
      this.onTap,
      this.color,
      this.logoasset,
      this.title,
      this.padding,
      this.canSubmit,
      this.isLoading,
      @required this.themeData})
      : assert(title != null, logoasset != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!canSubmit)
      return Container(
        color: themeData.primaryColor,
        alignment: Alignment.center,
        width: config.width,
        height: config.height * 0.063,
        child: CircularProgressIndicator(),
      );
    // ignore: deprecated_member_use
    return RaisedButton(
      onPressed: canSubmit
          ? onTap
          : () {
              print('Cannot Submit');
            },
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(config.width * 0.1),
      ),
      color: !isLoading ? color : themeData.primaryColor,
      child: Container(
        width: config.width,
        height: config.height * 0.063,
        child: Row(
          children: [
            SizedBox(
              width: padding ?? config.width * 0.07,
            ),
            SvgPicture.asset(
              logoasset,
              height: config.height * 0.045,
            ),
            SizedBox(
              width: config.width * 0.11,
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'VarelaRound',
                color: greyishWhite,
                fontSize: config.width * 0.054,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
