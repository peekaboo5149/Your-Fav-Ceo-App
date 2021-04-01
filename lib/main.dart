import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application/auth/auth_provider.dart';
import 'application/theme/dynamic_theme.dart';
import 'infrastructure/auth/auth_service.dart';
import 'presentation/auth/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final IAuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: DynamicTheme()),
          ChangeNotifierProvider.value(value: AuthProvider(auth: _auth)),
          StreamProvider<User>.value(
            value: _auth.getCurrentUserState(),
            initialData: _auth.getCurrentUser(),
            catchError: (_, e) {
              print(e.toString());
              return null;
            },
          ),
        ],
        child: Consumer<DynamicTheme>(
          builder: (context, value, child) => MaterialApp(
            title: 'your fav ceo',
            debugShowCheckedModeBanner: false,
            theme: value.theme,
            home: Wrapper(),
          ),
        ));
  }
}
