import 'package:flutter/material.dart';

import '../../core/config.dart';
import '../../models/ceo_models.dart';

class SwipableCard extends StatelessWidget {
  final CEO ceo;
  final int index;
  final Config config;

  const SwipableCard({
    Key key,
    @required this.ceo,
    @required this.index,
    @required this.config,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(config.width * 0.1))),
      elevation: 5.0,
      child: Container(
        padding: EdgeInsets.only(left: config.width * 0.03),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.antiAlias,
          children: [
            _buildFeedBackLike(
              '👍',
              ceo.upvotes,
            ),
            _buildFeedBackDislike('👎', ceo.downvotes),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ceo.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cabin',
                    fontSize: config.width * 0.06,
                  ),
                ),
                SizedBox(
                  height: config.height * 0.01,
                ),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Cabin',
                        fontSize: config.width * 0.036,
                      ),
                      text: ceo.designation,
                      children: [
                        TextSpan(
                          text: ", " + ceo.company,
                        )
                      ]),
                ),
                SizedBox(
                  height: config.height * 0.07,
                )
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(config.width * 0.1)),
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.35), BlendMode.darken),
                onError: (exception, stackTrace) {
                  print(exception.toString());
                },
                fit: BoxFit.fill,
                image: NetworkImage(
                  ceo.imageurl,
                ))),
      ),
    );
  }

  Positioned _buildFeedBackLike(String icon, int upvotes) {
    return Positioned(
        top: config.width * 0.03,
        right: config.width * 0.01,
        child: Column(
          children: [
            Text(
              icon,
              style: TextStyle(
                fontSize: config.width * 0.07,
              ),
            ),
            Text(
              upvotes.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: config.width * 0.06,
              ),
            )
          ],
        ));
  }

  Positioned _buildFeedBackDislike(String icon, int downvotes) {
    return Positioned(
        top: config.width * 0.03,
        left: config.width * 0.01,
        child: Column(
          children: [
            Text(
              icon,
              style: TextStyle(
                fontSize: config.width * 0.07,
              ),
            ),
            Text(
              downvotes.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: config.width * 0.06,
              ),
            )
          ],
        ));
  }
}
