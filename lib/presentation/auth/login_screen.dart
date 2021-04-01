import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../application/auth/auth_provider.dart';
import '../../application/theme/dynamic_theme.dart';
import '../../core/config.dart';
import '../../core/constants.dart';
import '../widgets/custom_material_button.dart';

part 'onboarding_part_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authprovier = Provider.of<AuthProvider>(context, listen: false);
    final theme = Theme.of(context);
    final config = Config(context);
    final themeprovider = Provider.of<DynamicTheme>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: config.height,
          width: config.width,
          color: theme.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: config.height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: config.width * 0.06,
                  right: config.width * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'your fav ceo',
                      style: kappTextStyle.copyWith(
                        color: theme.accentColor,
                        fontSize: config.width * 0.06,
                      ),
                    ),
                    IconButton(
                      icon: Icon(themeprovider.appIcon),
                      onPressed: () => themeprovider.toogleTheme(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: _OnBoardingScreen(
                  config: config,
                  themeData: themeprovider.theme,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: config.width * 0.07,
                    horizontal: config.width * 0.07,
                  ),
                  child: Column(
                    children: [
                      CustomMaterialButton(
                        config: config,
                        onTap: () async {
                          try {
                            await authprovier.submit();
                          } on PlatformException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message)));
                          }
                        },
                        color: facebookBlue,
                        title: 'Facebook',
                        logoasset: 'assets/svgs/facebook.svg',
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
