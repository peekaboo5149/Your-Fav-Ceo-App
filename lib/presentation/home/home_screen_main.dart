import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcard/tcard.dart';
import 'package:your_fav_ceo/core/config.dart';
import 'package:your_fav_ceo/infrastructure/database/cloud_database_service.dart';
import 'package:your_fav_ceo/models/ceo_models.dart';
import 'package:your_fav_ceo/presentation/widgets/swipable_card.dart';

class HomeMainScreen extends StatefulWidget {
  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  TCardController _controller = TCardController();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final config = Config(context);
    return FutureProvider<List<CEO>>.value(
      value: CloudDatabaseService.getUnvisitedCEOs(),
      catchError: (context, error) {
        print(error.toString());
        return [];
      },
      initialData: [],
      child: FutureProvider<SharedPreferences>.value(
        initialData: null,
        value: SharedPreferences.getInstance(),
        child: _buildCardView(config, theme),
      ),
    );
  }

  _buildCardView(
    config,
    theme,
  ) {
    return Consumer<SharedPreferences>(builder: (context, prefs, child) {
      if (prefs != null) {
        Map user = json.decode(prefs.getString('cUser'));

        return Consumer<List<CEO>>(
          builder: (context, ceos, child) {
            if (ceos.isEmpty) return Text('NO data');
            List<Widget> cards = List.generate(
              ceos.length,
              (int index) {
                return SwipableCard(ceos[index]);
              },
            );
            return Center(
              child: TCard(
                cards: cards,
                controller: _controller,
                onForward: (index, info) {
                  _index = index;
                  print(info.direction);
                  setState(() {});
                },
                onBack: (index, info) {
                  _index = index;
                  print(info.direction);
                  setState(() {});
                },
                onEnd: () {
                  print('end');
                },
              ),
            );
          },
        );
      }

      return Container(
        child: CircularProgressIndicator(),
      );
    });
  }
}
