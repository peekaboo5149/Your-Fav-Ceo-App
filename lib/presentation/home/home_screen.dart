import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_fav_ceo/core/config.dart';
import 'package:your_fav_ceo/infrastructure/database/cloud_database_service.dart';
import 'package:your_fav_ceo/models/ceo_models.dart';
import 'package:your_fav_ceo/presentation/widgets/ceo_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final config = Config(context);
    return StreamProvider<List<CEO>>.value(
      initialData: [],
      value: CloudDatabaseService.getTopCeos(10),
      child: SingleChildScrollView(
        child: Container(
          width: config.width,
          height: config.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: config.height * 0.06),
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
