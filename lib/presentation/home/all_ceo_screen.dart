import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_fav_ceo/core/config.dart';
import 'package:your_fav_ceo/infrastructure/database/cloud_database_service.dart';
import 'package:your_fav_ceo/models/ceo_models.dart';
import 'package:your_fav_ceo/presentation/widgets/custom_cards.dart';

class AllCeoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Config config = Config(context);
    return StreamProvider<List<CEO>>.value(
        value: CloudDatabaseService.getTopCeos(6),
        initialData: [],
        child: Consumer<List<CEO>>(
          builder: (context, value, child) {
            if (value.isEmpty)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) =>
                  CustomCards(config: config, themeData: theme),
            );
          },
        ));
  }
}
