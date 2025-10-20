import 'dart:async';

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Use local Montserrat font declared in pubspec.yaml
import 'package:shared_preferences/shared_preferences.dart';

// Global theme controller so screens/widgets can toggle theme at runtime.
final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.system);

// Persist theme changes
void setupThemePersistence() {
  appThemeMode.addListener(() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final mode = appThemeMode.value;
      final str = mode == ThemeMode.light
          ? 'light'
          : mode == ThemeMode.dark
          ? 'dark'
          : 'system';
      await prefs.setString('preferred_theme_mode', str);
    } catch (_) {
      // ignore write errors
    }
  });
}

class OsonMarketApp extends StatelessWidget {
  const OsonMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.light();
    const primaryColor = Color(0xFFE91E63); // #E91E63
    const primaryAccent = Color(0xFFFF4081);
    final colorScheme = base.colorScheme.copyWith(
      primary: primaryColor,
      secondary: primaryAccent,
    );
    final textTheme = base.textTheme.apply(fontFamily: 'Montserrat');
    // Keep status bar styling consistent with app scaffold background.
    // We'll set overlay style once the app builds so it aligns with themeMode.

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          themeMode: mode,
          title: 'OSON MARKET',
          localizationsDelegates: [
            const AppLocalizationsDelegate(),
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ru'), Locale('uz')],
          debugShowCheckedModeBanner: false,
          theme: base.copyWith(
            colorScheme: colorScheme,
            textTheme: textTheme,
            primaryColor: Colors.pink,
            scaffoldBackgroundColor: Colors.grey.shade50,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 0.5,
              centerTitle: true,
              toolbarHeight: 56,
              iconTheme: const IconThemeData(color: Colors.black87),
              titleTextStyle: textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: colorScheme.primary,
              unselectedItemColor: Colors.grey.shade600,
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 12),
              elevation: 6,
              type: BottomNavigationBarType.fixed,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          // Mirror AppBar / BottomNavigationBar styles in dark theme so these
          // components visually remain the same regardless of themeMode.
          darkTheme: base.copyWith(
            colorScheme: colorScheme.copyWith(brightness: Brightness.dark),
            textTheme: textTheme,
            primaryColor: Colors.pink,
            scaffoldBackgroundColor: const Color(0xFF0F0F10),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 0.5,
              centerTitle: true,
              toolbarHeight: 56,
              iconTheme: const IconThemeData(color: Colors.black87),
              titleTextStyle: textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: colorScheme.primary,
              unselectedItemColor: Colors.grey.shade600,
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 12),
              elevation: 6,
              type: BottomNavigationBarType.fixed,
            ),
          ),
          home: const _AnimatedSplash(),
        );
      },
    );
  }
}

class _AnimatedSplash extends StatefulWidget {
  const _AnimatedSplash();

  @override
  State<_AnimatedSplash> createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<_AnimatedSplash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl;
  late final Animation<double> _scale;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scale = CurvedAnimation(parent: _ctl, curve: Curves.elasticOut);
    _ctl.forward();
    _navigationTimer = Timer(const Duration(milliseconds: 1100), () {
      if (!mounted) return;
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe91e63),
      body: Center(
        child: ScaleTransition(
          scale: _scale,
          child: Image.asset(
            'assets/app_icon_anim.png',
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

// Minimal home widget expected by older code/tests.
class OsonMarket extends StatelessWidget {
  const OsonMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OSON MARKET',
          style: TextStyle(fontFamily: 'Gagalin'),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Приложение запущено (placeholder Home)'),
              ),
            );
          },
          child: const Text('Открыть приложение'),
        ),
      ),
    );
  }
}

// ...existing code...
