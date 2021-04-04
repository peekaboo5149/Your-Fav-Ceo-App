import 'package:flutter/material.dart';
import 'package:your_fav_ceo/models/ceo_models.dart';

class SwipableCard extends StatelessWidget {
  final CEO ceo;

  const SwipableCard(this.ceo);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(child: Text(ceo.name)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
