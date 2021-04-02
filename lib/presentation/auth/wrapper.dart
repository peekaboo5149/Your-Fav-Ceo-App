import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/dashboard_screen.dart';
import 'login_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<User>(context);
    if (userprovider == null) {
      return LoginScreen();
    }
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
          if (prefs.connectionState == ConnectionState.done) {
            Map<String, String> userPrefs = {
              'email': userprovider.email,
              'imgUrl': userprovider.photoURL
            };
            prefs.data.setString('cUser', json.encode(userPrefs));
            return DashBoardScreen();
          } else
            return _buildLoadingScreen();
        });
  }

  _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
