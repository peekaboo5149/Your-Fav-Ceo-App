import 'package:flutter/foundation.dart';
import 'package:your_fav_ceo/infrastructure/database/cloud_database_service.dart';
import 'package:your_fav_ceo/models/ceo_models.dart';

class PaginationProvider with ChangeNotifier {
  List<CEO> _ceos = [];
  CloudDatabaseService service = CloudDatabaseService();

  bool isLoading;

  List<CEO> get ceos => [...this._ceos];

  // PaginationProvider() {
  //   fetchCEOs();
  // }

  // fetchCEOs() {
  //   service.getTopCeos(5).listen((event) {
  //     _ceos.addAll(event);
  //   });
  //   notifyListeners();
  // }
}
