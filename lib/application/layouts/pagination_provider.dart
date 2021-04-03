import 'package:flutter/foundation.dart';

import '../../models/ceo_models.dart';

class PaginationProvider with ChangeNotifier {
  final List<CEO> _ceoList = [];
  String _errorMessage = '';
  final int _documentLimit = 4;
  bool _hasNext = true;
  bool _isFetchingEntries = false;

  String get errorMessage => this._errorMessage;

  List<CEO> get users => this._ceoList;

  fetchNextCEOEntries() {
    if (_isFetchingEntries) return;

    _errorMessage = '';
    _isFetchingEntries = true;
    try {} catch (e) {}
  }
}
