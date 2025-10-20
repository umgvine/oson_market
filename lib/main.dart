import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemePrefKey = 'preferred_theme_mode';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFE91E63),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  // Load saved theme mode (if any) before starting the app
  try {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kThemePrefKey);
    if (saved != null) {
      switch (saved) {
        case 'light':
          appThemeMode.value = ThemeMode.light;
          break;
        case 'dark':
          appThemeMode.value = ThemeMode.dark;
          break;
        default:
          appThemeMode.value = ThemeMode.system;
      }
    }
  } catch (_) {
    // ignore prefs errors and continue with default
  }

  // Ensure persistence listener is set up so future changes are saved.
  setupThemePersistence();

  runApp(const OsonMarketApp());
}
