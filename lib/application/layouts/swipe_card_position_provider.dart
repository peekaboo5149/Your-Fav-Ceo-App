import 'package:flutter/foundation.dart';

enum SwipeDirection { left, right, none }

class SwipeCardPositionProvider with ChangeNotifier {
  double _dx = 0.0;
  SwipeDirection _swipeDirection;

  SwipeDirection get swipingDirection => _swipeDirection;

  SwipeCardPositionProvider() {
    _swipeDirection = SwipeDirection.none;
  }

  void resetPosition() {
    _dx = 0.0;
    _swipeDirection = SwipeDirection.none;
    notifyListeners();
  }
}
