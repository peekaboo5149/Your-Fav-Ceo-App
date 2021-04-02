import 'package:flutter/material.dart';
import 'package:your_fav_ceo/core/config.dart';
import 'package:your_fav_ceo/models/ceo_models.dart';

class SwipeCards extends StatelessWidget {
  const SwipeCards({
    Key key,
    @required this.config,
    this.isLoading = false,
    this.ceo,
    this.isBlank = false,
  }) : super(key: key);

  final Config config;
  final bool isLoading;
  final bool isBlank;
  final CEO ceo;

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
        child: isLoading
            ? isBlank
                ? SizedBox()
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : Column(
                children: [
                  Text(ceo.name),
                ],
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
