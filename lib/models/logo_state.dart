import 'package:flutter/cupertino.dart';

class LogoState with ChangeNotifier {
  String _logoUrl = 'assets/images/logo_purena.svg';

  String get logoUrl => _logoUrl;

  set logoUrl(String newValue) {
    _logoUrl = newValue;
    notifyListeners();
  }
}
