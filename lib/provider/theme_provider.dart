import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark;

  ThemeProvider(this._isDark);

  bool get isDark => _isDark;

  void toggleTheme(bool value)  {
    _isDark = value;
    notifyListeners();

  }
}
