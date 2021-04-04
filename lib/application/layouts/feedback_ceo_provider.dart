import 'package:flutter/foundation.dart';

class FeedBackProvider with ChangeNotifier {
  bool hasEnded;

  FeedBackProvider({
    this.hasEnded = false,
  });

  updateWith({
    bool hasEnded,
  }) {
    this.hasEnded = hasEnded ?? this.hasEnded;

    notifyListeners();
  }
}
