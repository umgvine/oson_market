import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Minimal localization layer used across the YA Market app.
///
/// The project currently relies on hard-coded strings in many places, but
/// `MaterialApp` expects a localization delegate. This implementation keeps the
/// delegate lightweight while still allowing future widgets to request
/// localized strings via strongly typed getters or the [translate] helper.
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// Simple key/value maps for the few strings that currently need
  /// localization. Fallbacks to English when a key is missing.
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'YA MARKET',
      'openApp': 'Open app',
      'cart': 'Cart',
      'checkout': 'Checkout',
    },
    'ru': {
      'appTitle': 'YA MARKET',
      'openApp': 'Открыть приложение',
      'cart': 'Корзина',
      'checkout': 'Оформление заказа',
    },
    'uz': {
      'appTitle': 'YA MARKET',
      'openApp': 'Ilovani ochish',
      'cart': 'Savat',
      'checkout': 'Buyurtma',
    },
  };

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  String translate(String key) {
    final langCode = locale.languageCode;
    final localeValues = _localizedValues[langCode] ?? _localizedValues['en']!;
    return localeValues[key] ?? _localizedValues['en']![key] ?? key;
  }

  String get appTitle => translate('appTitle');
  String get openApp => translate('openApp');
  String get cart => translate('cart');
  String get checkout => translate('checkout');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (l) => l.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
