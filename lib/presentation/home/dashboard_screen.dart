import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:your_fav_ceo/application/layouts/navigation_provider.dart';
import 'package:your_fav_ceo/application/theme/dynamic_theme.dart';
import 'package:your_fav_ceo/presentation/home/all_ceo_screen.dart';
import 'package:your_fav_ceo/presentation/home/home_screen.dart';
import 'package:your_fav_ceo/presentation/home/settings.dart';
import 'package:your_fav_ceo/presentation/home/top_ceo_screen.dart';

import '../../application/auth/auth_provider.dart';
import '../../core/constants.dart';

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context, listen: false);
    final ThemeData theme = Theme.of(context);
    print(authprovider.currentUser.uid);

    return ChangeNotifierProvider.value(
      value: NavigationProvider(),
      child: Consumer<NavigationProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: greyishWhite,
          appBar: _buildAppBar(
            text: value.appTitle,
            theme: theme,
            authprovider: authprovider,
            context: context,
          ),
          bottomNavigationBar: _buildNavigationBar(
            theme: theme,
            onTap: (val) => value.navigate(val),
          ),
          body: _buildbody(navigationProvider: value),
        ),
      ),
    );
  }

  Widget _buildbody({@required NavigationProvider navigationProvider}) {
    return navigationProvider.currentPage == 0
        ? HomeScreen()
        : (navigationProvider.currentPage == 1
            ? TopCeoScreen()
            : AllCeoScreen());
  }

  AppBar _buildAppBar(
      {@required String text,
      @required ThemeData theme,
      @required AuthProvider authprovider,
      @required BuildContext context}) {
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
              Icons.settings,
              color: theme.accentColor,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Settings()));
            }),
        IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: theme.accentColor,
            ),
            onPressed: () async {
              try {
                authprovider.updateWith(isLoading: true);
                await authprovider.logout();
                authprovider.updateWith(isLoading: false);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('COULDN\'T LOGOUT!!!!')));
              }
            })
      ],
    );
  }

  CurvedNavigationBar _buildNavigationBar({
    @required ThemeData theme,
    @required ValueChanged onTap,
  }) {
    return CurvedNavigationBar(
      backgroundColor: theme.primaryColor,
      onTap: onTap,
      items: [
        Icon(Icons.dashboard),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: SvgPicture.asset('assets/svgs/winner_dark.svg'),
            ),
          ),
        ),
        Icon(Icons.list),
      ],
    );
  }
}
