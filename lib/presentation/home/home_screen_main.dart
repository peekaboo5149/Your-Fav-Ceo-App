import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcard/tcard.dart';
import 'package:your_fav_ceo/application/layouts/feedback_ceo_provider.dart';
import 'package:your_fav_ceo/core/config.dart';
import 'package:your_fav_ceo/infrastructure/database/cloud_database_service.dart';
import 'package:your_fav_ceo/models/ceo_models.dart';
import 'package:your_fav_ceo/presentation/home/settings.dart';
import 'package:your_fav_ceo/presentation/widgets/blank_widget.dart';
import 'package:your_fav_ceo/presentation/widgets/swipable_card.dart';

class HomeMainScreen extends StatefulWidget {
  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  TCardController _cardController = TCardController();

  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedBackProvider>(context);
    final ThemeData theme = Theme.of(context);
    final config = Config(context);
    return FutureProvider<SharedPreferences>.value(
      value: SharedPreferences.getInstance(),
      initialData: null,
      child: Container(
        width: config.width,
        height: config.height,
        color: theme.primaryColor,
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(
          left: config.width * 0.1,
          top: config.height * 0.04,
          right: config.width * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<SharedPreferences>(
              builder: (context, value, child) {
                if (value == null)
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: config.width * 0.1,
                  );

                Map user = json.decode(value.getString('cUser'));
                return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Settings())),
                  child: Hero(
                    tag: "profilepic",
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: config.width * 0.13,
                      backgroundImage: NetworkImage(user['imgUrl']),
                    ),
                  ),
                );
              },
            ),
            Consumer<SharedPreferences>(
              builder: (context, prefs, child) {
                if (prefs == null) return Container();
                Map user = json.decode(prefs.getString('cUser'));
                return _buildTCards(config, theme, user, feedbackProvider);
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildTCards(Config config, ThemeData theme, Map user,
      FeedBackProvider feedBackProvider) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(config.width * 0.1),
        alignment: Alignment.center,
        child: FutureBuilder<List<CEO>>(
          future: CloudDatabaseService.getUnvisitedCEOs(),
          initialData: [],
          builder: (context, AsyncSnapshot<List<CEO>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  'No data',
                  style: TextStyle(color: theme.accentColor),
                ),
              );
            }

            List<Widget> cards = List.generate(
              snapshot.data.length,
              (int index) {
                return SwipableCard(
                  config: config,
                  ceo: snapshot.data[index],
                  index: index,
                );
              },
            );
            print("Length " + snapshot.data.length.toString());

            if (cards.length == 0) {
              return BlankCardWidget(config: config);
            }

            return !feedBackProvider.hasEnded
                ? TCard(
                    cards: cards,
                    controller: _cardController,
                    lockYAxis: true,
                    onForward: (index, info) async {
                      if (info.direction == SwipDirection.Right) {
                        await CloudDatabaseService.updateUserCeoList(
                            user['uid'], snapshot.data[index - 1].id, true);
                      } else if (info.direction == SwipDirection.Left) {
                        await CloudDatabaseService.updateUserCeoList(
                            user['uid'], snapshot.data[index - 1].id, false);
                      }
                    },
                    onEnd: () {
                      print("end");
                      feedBackProvider.updateWith(hasEnded: true);
                    },
                  )
                : BlankCardWidget(config: config);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }
}

// cContainerlass HomeMainScreen extends StatefulWidget {
//   @override
//   _HomeMainScreenState createState() => _HomeMainScreenState();
// }

// class _HomeMainScreenState extends State<HomeMainScreen> {
//   TCardController _controller = TCanullrdController();
//   List<CEO> cards = [];

//   getData() {
//     CloudDatabaseService.getUnvisitedCEOs()
//         .then((value) => cards.addAll(value));
//   }

//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final config = Config(context);
//     return FutureProvider<List<CEO>>.value(
//       value: CloudDatabaseService.getUnvisitedCEOs(),
//       catchError: (context, error) {
//         print(error.toString());
//         return [];
//       },
//       initialData: [],
//       child: FutureProvider<SharedPreferences>.value(
//         initialData: null,
//         value: SharedPreferences.getInstance(),
//         child: _buildCardView(config, theme),
//       ),
//     );
//   }

//   _buildCardView(
//     config,
//     theme,
//   ) {
//     return Consumer<SharedPreferences>(builder: (context, prefs, child) {
//       if (prefs != null) {
//         Map user = json.decode(prefs.getString('cUser'));

//         return Consumer<List<CEO>>(
//           builder: (context, ceos, child) {
//             if (ceos.isEmpty) return Text('NO data');
//             print('ceo' + ceos.length.toString());
//             List<Widget> cards = List.generate(
//               ceos.length,
//               (int index) {
//                 return SwipableCard(ceos[index], index);
//               },
//             );
//             return Center(
//               child: TCard(
//                 lockYAxis: true,
//                 cards: cards,
//                 controller: _controller,
//                 onForward: (index, info) async {
//                   info.direction == SwipDirection.Left
//                       ? await CloudDatabaseService.updateUserCeoList(
//                           user['uid'], ceos[index - 1].id, true)
//                       : await CloudDatabaseService.updateUserCeoList(
//                           user['uid'],
//                           ceos[index - 1].id,
//                           false,
//                         );
//                   setState(() {});
//                 },
//                 onEnd: () {
//                   return Center(child: Text('ended'));
//                 },
//               ),
//             );
//           },
//         );
//       }

//       return Container(
//         child: CircularProgressIndicator(),
//       );true
//     });
//   }
// }
