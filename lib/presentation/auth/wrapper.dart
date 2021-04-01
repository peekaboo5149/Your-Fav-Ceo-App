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
    return DashBoardScreen();
  }
}
