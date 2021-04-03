import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_fav_ceo/application/theme/dynamic_theme.dart';
import 'package:your_fav_ceo/core/config.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Config config = Config(context);
    final themeprovider = Provider.of<DynamicTheme>(context);
    final ThemeData theme = Theme.of(context);
    return FutureProvider<SharedPreferences>.value(
      value: SharedPreferences.getInstance(),
      initialData: null,
      child: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.accentColor,
              ),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: Consumer<SharedPreferences>(
          builder: (context, value, child) {
            if (value == null) return Container();

            Map user = json.decode(value.getString('cUser'));

            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: config.height * 0.05,
                  ),
                  Hero(
                    tag: 'profilepic',
                    child: CircleAvatar(
                      radius: config.width * 0.2,
                      backgroundImage: NetworkImage(user['imgUrl']),
                    ),
                  ),
                  SizedBox(
                    height: config.height * 0.02,
                  ),
                  Text(
                    user['email'],
                    style: TextStyle(
                      fontFamily: 'Cabin',
                      letterSpacing: 1.6,
                      color: theme.accentColor,
                      fontSize: config.width * 0.06,
                    ),
                  ),
                  SizedBox(
                    height: config.height * 0.1,
                  ),
                  // Container(
                  //   color: Colors.red,
                  //   width: config.width,
                  //   height: config.height * 0.07,
                  //   child: Row(
                  //     children: [

                  //     ],
                  //   ),
                  // )
                  ListTile(
                    leading: Text(
                      'Switch Theme',
                      style: TextStyle(
                        color: theme.accentColor,
                        fontFamily: 'VarelaRound',
                        fontWeight: FontWeight.bold,
                        fontSize: config.width * 0.04,
                      ),
                    ),
                    trailing: Switch(
                        value: themeprovider.darkTheme,
                        onChanged: (val) {
                          themeprovider.darkTheme = !themeprovider.darkTheme;
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
