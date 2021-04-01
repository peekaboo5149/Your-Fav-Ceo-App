import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_fav_ceo/application/layouts/navigation_provider.dart';
import 'package:your_fav_ceo/presentation/home/all_ceo_screen.dart';
import 'package:your_fav_ceo/presentation/home/home_screen.dart';
import 'package:your_fav_ceo/presentation/home/top_ceo_screen.dart';

import '../../application/auth/auth_provider.dart';
import '../../core/config.dart';
import '../../core/constants.dart';

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
    final Config config = Config(context);
    final ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider.value(
      value: NavigationProvider(),
      child: Consumer<NavigationProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: theme.primaryColor,
          appBar: _buildAppBar(value.appTitle, theme, authprovider),
          bottomNavigationBar: _buildNavigationBar(theme, (val) {
            value.navigate(val);
          }),
          body: _buildbody(value),
        ),
      ),
    );
  }

  Widget _buildbody(NavigationProvider value) {
    return value.currentPage == 0
        ? HomeScreen()
        : (value.currentPage == 1 ? TopCeoScreen() : AllCeoScreen());
  }

  AppBar _buildAppBar(String text, ThemeData theme, AuthProvider authprovider) {
    return AppBar(
      elevation: 0.0,
      title: Text(
        text,
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
    );
  }

  CurvedNavigationBar _buildNavigationBar(ThemeData theme, ValueChanged onTap) {
    return CurvedNavigationBar(
      backgroundColor: theme.primaryColor,
      onTap: onTap,
      items: [
        Icon(Icons.dashboard),
        Icon(Icons.people),
        Icon(Icons.list),
      ],
    );
  }
}
