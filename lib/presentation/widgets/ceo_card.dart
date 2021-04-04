// import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:your_fav_ceo/core/constants.dart';

import '../../core/config.dart';
import '../../models/ceo_models.dart';

class SwipeCards extends StatelessWidget {
  const SwipeCards({
    Key key,
    @required this.config,
    this.isLoading = false,
    this.ceo,
    this.isBlank = false,
    this.isDisLiked = false,
    this.isLiked = false,
  }) : super(key: key);

  final Config config;
  final bool isLoading;
  final bool isBlank;
  final CEO ceo;
  final bool isLiked;
  final bool isDisLiked;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(config.width * 0.1)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(config.width * 0.1)),
        ),
        width: config.width * 0.7,
        height: config.width * 0.9,
        child: isLoading
            ? isBlank
                ? SizedBox()
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : LayoutBuilder(
                builder: (context, constraints) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.black26,
                      Colors.black12,
                    ]),
                    borderRadius:
                        BorderRadius.all(Radius.circular(config.width * 0.1)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: config.width * 0.1,
                      bottom: config.width * 0.1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ceo.name,
                          style: TextStyle(
                            color: dark,
                            fontFamily: 'Cabin',
                            fontSize: config.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class BlankCard extends StatelessWidget {
  final Config config;

  const BlankCard({Key key, this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(config.width * 0.1)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(config.width * 0.1)),
        ),
        width: config.width * 0.6,
        height: config.height * 0.5,
        child: SizedBox(),
      ),
    );
  }
}
