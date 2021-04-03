import 'package:flutter/material.dart';

import '../../core/config.dart';
import '../../models/ceo_models.dart';

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
                    // image: DecorationImage(
                    //   onError: (exception, stackTrace) {
                    //     print(exception.toString());
                    //   },
                    //   image: NetworkImage(
                    //     ceo.imageurl != null
                    //         ? ceo.imageurl
                    //         : 'https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2134&q=80',
                    //   ),
                    //   fit: BoxFit.fill,
                    // ),
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
