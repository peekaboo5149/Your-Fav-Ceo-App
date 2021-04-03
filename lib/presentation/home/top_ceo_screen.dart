import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config.dart';
import '../../infrastructure/database/cloud_database_service.dart';
import '../../models/ceo_models.dart';
import '../widgets/custom_cards.dart';

class TopCeoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Config config = Config(context);
    return StreamProvider<List<CEO>>.value(
      value: CloudDatabaseService.getAllCeos(limit: 3),
      initialData: [],
      child: LayoutBuilder(builder: (context, constraints) {
        return Consumer<List<CEO>>(builder: (context, value, child) {
          if (value.isEmpty)
            return Center(
              child: CircularProgressIndicator(),
            );
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) => CustomCards(
              name: value[index].name,
              number: value[index].upvotes,
              height: config.height * 0.25,
              config: config,
              // themeData: theme,
            ),
          );
        });
      }),
    );
  }
}
