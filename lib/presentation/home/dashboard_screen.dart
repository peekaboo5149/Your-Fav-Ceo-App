import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/auth/auth_provider.dart';
import '../../core/config.dart';
import '../../core/constants.dart';
import 'settings.dart';
import '../widgets/user_card.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<UserCard> usercards = [];

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
    final Config config = Config(context);
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: theme.primaryColor,
        onTap: (val) => print(val),
        items: [
          Icon(Icons.dashboard),
          Icon(Icons.people),
          Icon(Icons.list),
        ],
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'DashBoard',
          style: kappTextStyle.copyWith(
            color: theme.accentColor,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: theme.accentColor,
              ),
              onPressed: () async {
                await authprovider.logout();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: config.width,
          height: config.height,
          color: theme.primaryColor,
          child: Stack(
            children: [
              Positioned(
                  top: config.height * 0.05,
                  left: config.width * 0.05,
                  child: InkWell(
                    onTap: () {
                      print(authprovider.currentUser.email);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Settings()));
                    },
                    child: Hero(
                      tag: 'user_avatar',
                      child: CircleAvatar(
                        radius: config.width * 0.15,
                        backgroundColor: Colors.red.withOpacity(.1),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
