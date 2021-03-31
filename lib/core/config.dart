import 'package:flutter/material.dart';

class Config {
  final BuildContext _context;

  Config(this._context);

  MediaQueryData get _mediaQuery => MediaQuery.of(_context);
  double get width => _mediaQuery.size.width;
  double get height => _mediaQuery.size.height;
  Orientation get orientation => _mediaQuery.orientation;
}
