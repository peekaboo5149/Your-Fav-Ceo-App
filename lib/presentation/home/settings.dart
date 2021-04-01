import 'package:flutter/material.dart';
import '../../core/config.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Config config = Config(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        leading: IconButton(
            padding: EdgeInsets.only(
              left: config.width * 0.01,
              top: config.height * 0.01,
            ),
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.accentColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Hero(
              tag: 'user_avatar',
              child: CircleAvatar(
                backgroundColor: Colors.red.withOpacity(.1),
                radius: config.width * 0.3,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'ktanmay5149@gmail.com',
              style: TextStyle(
                color: theme.accentColor,
                fontFamily: 'VarelaRound',
                letterSpacing: 1.8,
                fontWeight: FontWeight.bold,
                fontSize: config.width * 0.04,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
