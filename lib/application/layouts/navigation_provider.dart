import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  NavigationProvider({this.currentPage = 0});

  int currentPage;

  String get appTitle {
    if (currentPage == 0) return 'your fav ceo';
    if (currentPage == 1) return 'Top 3 CEOS';
    return 'LEADERBOARD';
  }

  navigate(int val) {
    currentPage = val;
    notifyListeners();
  }
}
