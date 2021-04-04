import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config.dart';
import '../../infrastructure/database/cloud_database_service.dart';
import '../../models/ceo_models.dart';
import '../widgets/ceo_card.dart';
import 'settings.dart';

class HomeScreen extends StatelessWidget {
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
        child: _buildSingleChildScrollView(config, theme),
      ),
    );
  }

  SingleChildScrollView _buildSingleChildScrollView(
      Config config, ThemeData theme) {
    return SingleChildScrollView(
      child: Container(
        width: config.width,
        height: config.height,
        color: theme.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: config.height * 0.04),
            Padding(
              padding: EdgeInsets.only(left: config.width * 0.07),
              child: Consumer<SharedPreferences>(
                builder: (context, value, child) {
                  if (value != null) {
                    Map user = json.decode(value.getString('cUser'));
                    return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => Settings())),
                        child: Hero(
                          tag: 'profilepic',
                          child: CircleAvatar(
                            radius: config.width * 0.1,
                            backgroundImage: NetworkImage(user['imgUrl']),
                          ),
                        ));
                  }
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                  );
                },
              ),
            ),
            SizedBox(height: config.height * 0.06),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: theme.primaryColor,
                child: Center(
                  child: Consumer<List<CEO>>(
                    builder: (context, value, child) {
                      if (value.isEmpty)
                        return SwipeCards(config: config, isLoading: true);
                      return Stack(
                        children: value
                            .map((e) => _buildDraggable(config, e))
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Draggable<SwipeCards> _buildDraggable(Config config, CEO ceo) {
    return Draggable(
      onDragEnd: (details) {
        final minDrag = config.width * 0.1;
        if (details.offset.dx > minDrag)
          print("swipped off");
        else if (details.offset.dx < -minDrag) print("ceo is liked");
      },
      childWhenDragging: Container(
        width: config.width * 0.6,
        height: config.height * 0.5,
      ),
      feedback: Material(
        type: MaterialType.transparency,
        child: SwipeCards(
          config: config,
          ceo: ceo,
        ),
      ),
      child: SwipeCards(
        config: config,
        ceo: ceo,
      ),
    );
  }
}
