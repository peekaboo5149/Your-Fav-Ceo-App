import 'package:flutter/material.dart';
import 'package:your_fav_ceo/core/config.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final config = Config(context);
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        color: theme.primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: config.height * 0.06),
              Padding(
                padding: EdgeInsets.only(left: config.width * 0.048),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: config.width * 0.14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
