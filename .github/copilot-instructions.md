## Repo snapshot for AI coding agents

This file is a concise guide for automated coding agents (Copilot-style) working on the `oson_market` Flutter app. Focus on what is discoverable in the repository and what makes this project unique.

- **Project type**: Flutter e-commerce app (Dart, Flutter SDK). Multi-platform: Android, iOS, Linux, macOS, Windows, Web.
- **Primary entrypoints**: `lib/main.dart` (app bootstrap) and `lib/app.dart` (MaterialApp + theme + splash).

### Big picture architecture (what to know)

- **UI-first single-app structure**: most UI code lives under `lib/screens/`, widgets under `lib/widgets/`, models under `lib/models/`, core/shared code under `lib/core/`, and data/repositories under `lib/data/` or `lib/services/`.
- **Dual architecture pattern**: Main consumer app + separate admin panel (`lib/admin/`) with its own dashboard, product/order/user management screens.
- **App bootstrapping and global state**:
  - `lib/main.dart` initializes Flutter, system chrome, and reads a persisted theme preference from `SharedPreferences` using key `preferred_theme_mode`.
  - `lib/app.dart` exposes a global `ValueNotifier<ThemeMode>` named `appThemeMode` and `setupThemePersistence()` which listens to changes and persists them to the same preferences key. Many widgets toggle theme by writing to `appThemeMode.value`.
- **State management hybrid**: Uses both Provider (`LanguageProvider`, `ChangeNotifier`) and direct ValueNotifiers (`appThemeMode`, `CartService.items`) - not pure Provider architecture.
- **Localization**: uses `lib/l10n/app_localizations.dart` and delegates; supported locales are `en`, `ru`, and `uz` as defined in `lib/app.dart`.
- **Assets & fonts**: see `pubspec.yaml` — assets under `assets/` (banners, categories, subcategories, demo images) and fonts family `Montserrat` and `Gagalin`. Prefer `Image.asset('assets/...')` in splash and local placeholders; many images are also used via network (see `cached_network_image` usage).

### Key patterns & conventions (repo-specific)

- **Theme persistence**: read from `SharedPreferences` at startup in `main.dart` and persist on change using `setupThemePersistence()`. Use the literal preference key `preferred_theme_mode`.
- **Global theme controller**: use the `appThemeMode` `ValueNotifier` from `lib/app.dart` rather than creating new global singletons.
- **Singleton services**: `CartService` uses singleton pattern (`factory CartService() => _instance`) with `ValueNotifier<Map<int, Map<String, dynamic>>> items` for reactive cart state. Persists to `SharedPreferences` with key `oson_cart_v1`.
- **Mixed state management**: Global singletons (`CartService`) + Provider pattern (`LanguageProvider`) + direct ValueListeners. No single state management approach.
- **App navigation on splash**: `_AnimatedSplash` in `lib/app.dart` uses `Navigator.pushReplacement(...)` to `HomeScreen` after ~1100ms animation delay — tests may assume this behavior.
- **Fonts**: text themes rely on Montserrat; AppBar title uses `Gagalin` in some widgets. Keep fontFamily values intact when editing theme-related code.
- **Static demo data**: `lib/data/data.dart` contains hardcoded products/categories lists with `initData()` function - no real backend integration yet.
- **Minimal compatibility class**: `OsonMarket` at the bottom of `lib/app.dart` is a small scaffold used by older tests — if editing `lib/app.dart`, keep this minimal widget or update tests accordingly.

### Developer workflows (commands & tips)

- Build and run (debug on Linux/macOS/Android/iOS): use the standard Flutter commands in project root:

  - flutter pub get
  - flutter run

- Run unit/widget tests:

  - flutter test

- Common CI note: This project includes native platforms (android/ios/linux/macos/windows). CI should run `flutter pub get` and `flutter test` and, if running platform builds, `flutter build apk` or `flutter build ios` as needed.

### Files to check when making changes

- Theme / startup: `lib/main.dart`, `lib/app.dart`
- Screens: `lib/screens/` (home and product screens live here)
- Networking & data: `lib/data/` or `lib/services/` (look for `http` usage)
- Localization: `lib/l10n/app_localizations.dart` and `pubspec.yaml` for locale support
- Tests: `test/` — includes `product_detail_test.dart`, `image_height_test.dart`, `widget_test.dart`. Run these after making UI changes that affect layout or widget tree.

### Integration points & external deps

- **HTTP**: package `http` is used for remote calls. Look for repository wrappers in `lib/data/` or `lib/services/`.
- **Caching images**: `cached_network_image` for remote images.
- **State & DI**: `provider` is present; global theme uses `ValueNotifier` instead of provider for theme. Combine both patterns carefully.
- **Shared preferences**: `shared_preferences` used for simple persistence with these keys: `preferred_theme_mode` (theme), `language` (locale), `oson_cart_v1` (cart data JSON).
- **Admin panel**: Complete separate UI flow in `lib/admin/` - admin login screen → dashboard with bottom nav (products/orders/users management). Admin screens use hardcoded demo data.

### Examples agents should follow

- When changing the theme flow, update `main.dart` and `app.dart` together: `main.dart` reads the persisted value; `app.dart` exposes `appThemeMode` and `setupThemePersistence()` for writes.
- When adding an asset, add the path to `pubspec.yaml` under `flutter.assets` so Flutter can package it.
- When modifying localization strings, update `lib/l10n/...` and ensure `AppLocalizationsDelegate` is kept in `MaterialApp.localizationsDelegates`.

### Tests & compatibility notes

- **Keep the `OsonMarket` minimal scaffold in `lib/app.dart`** or update tests that reference it. Some tests rely on this simple widget instead of the full app.
- **UI timing**: `_AnimatedSplash` navigates after ~1100ms — tests that depend on immediate navigation may need to pump timers or stub the animation.
- **ProductDetailScreen tests**: Expect quantity increment/decrement controls and `onAddToCart` callback to be called multiple times based on quantity (see `product_detail_test.dart`).

### Safety rules for automated edits

- **Preserve preference keys** (`preferred_theme_mode`, `language`, `oson_cart_v1`) and public ValueNotifier name `appThemeMode` unless updating all usages.
- **Don't remove the simple `OsonMarket` class** without updating tests.
- **When editing pubspec assets or fonts**, run `flutter pub get` and ensure asset paths exist; otherwise `flutter build` will warn or fail.
- **CartService singleton**: Don't change the factory constructor pattern or `items` ValueNotifier structure without updating all cart-related screens.

If anything in these notes is unclear or you'd like more examples (e.g., typical service class or provider wiring), tell me which area to expand and I'll iterate.
