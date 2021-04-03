import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config.dart';
import '../../infrastructure/database/cloud_database_service.dart';
import '../../models/ceo_models.dart';
import '../widgets/custom_cards.dart';

class AllCeoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Config config = Config(context);
    return StreamProvider<List<CEO>>.value(
        value: CloudDatabaseService.getAllCeos(),
        initialData: [],
        child: Consumer<List<CEO>>(
          builder: (context, value, child) {
            if (value.isEmpty)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) => CustomCards(
                flex: true,
                name: value[index].name,
                // height: config.height * 0.2,
                number: value[index].upvotes,
                config: config,
                // themeData: theme,
              ),
            );
          },
        ));
  }
}
