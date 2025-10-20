import 'package:flutter/material.dart';
import '../data/data.dart';
import 'home_screen_content.dart' as content;
import '../services/cart_service.dart';
import 'cart_screen.dart';
import '../core/theme.dart';
import '../widgets/header_bar.dart';
import '../widgets/search_bar.dart';
import '../app.dart' show appThemeMode; // For theme mode control

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final CartService _cart = CartService();
  List<Map<String, dynamic>> _filteredProducts = [];
  String? _activeCategory;
  String? _activeSubcategory;

  void _openSettingsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final theme = Theme.of(context);
        final current = appThemeMode.value;
        Widget tile(ThemeMode mode, String label, IconData icon) {
          final selected = current == mode;
          return ListTile(
            leading: Icon(
              icon,
              color: selected ? theme.colorScheme.primary : Colors.white70,
            ),
            title: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            trailing: selected
                ? const Icon(Icons.check_circle, color: Colors.white)
                : const Icon(
                    Icons.circle_outlined,
                    color: Colors.white38,
                    size: 20,
                  ),
            onTap: () {
              appThemeMode.value = mode;
              Navigator.pop(ctx);
            },
          );
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF312E81), Color(0xFF6D28D9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 46,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Настройки',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                tile(ThemeMode.system, 'Системная тема', Icons.phone_android),
                tile(ThemeMode.light, 'Светлая тема', Icons.light_mode),
                tile(ThemeMode.dark, 'Тёмная тема', Icons.dark_mode),
                const Divider(color: Colors.white24, height: 1),
                ListTile(
                  leading: const Icon(Icons.translate, color: Colors.white70),
                  title: const Text(
                    'Язык (скоро)',
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initData();
    // load persisted cart
    _cart.load().then((_) => setState(() {}));
  }

  // Columns calculation is kept in HomeScreenContent; remove to avoid unused warnings.

  @override
  Widget build(BuildContext context) {
    // ...existing code...

    // Shell used to render header + search + content so AppBar and search appear on every tab
    Widget screenShell({required Widget child}) {
      return Container(
        decoration: const BoxDecoration(gradient: kAppGradient),
        child: Column(
          children: [
            HeaderBar(
              onProfile: () => setState(() => _currentIndex = 3),
              onSettings: _openSettingsSheet,
            ),
            const AppSearchBar(),
            Expanded(child: child),
          ],
        ),
      );
    }

    // The four tabs: Home, Categories, Cart, Profile
    final tabs = <Widget>[
      // Home tab: reuse HomeScreenContent to keep layout consistent
      screenShell(
        child: content.HomeScreenContent(
          showHeader: false,
          products: _filteredProducts.isEmpty ? products : _filteredProducts,
          onAddToCart: (product) {
            _cart.add(product, 1);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Добавлено 1 шт.')));
            setState(() {});
          },
          onFilter: (category, subcategory) {
            setState(() {
              _activeCategory = category;
              _activeSubcategory = subcategory;
              if (subcategory != null) {
                _filteredProducts = products.where((p) {
                  if (p.containsKey('subcategory')) {
                    return p['subcategory'] == subcategory;
                  }
                  return p['cat'] == category;
                }).toList();
              } else {
                _filteredProducts = products
                    .where((p) => p['cat'] == category)
                    .toList();
              }
              _currentIndex = 0;
            });
          },
        ),
      ),
      // Categories tab wrapped in shell so header+search are present
      screenShell(
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: categories.length,
            itemBuilder: (ctx, i) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(categories[i]['img'] as String),
                ),
                title: Text(
                  categories[i]['name'],
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Открыть категорию ${categories[i]['name']}'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      // Cart tab wrapped in shell
      screenShell(child: const CartContent(embedded: true)),
      // Profile tab wrapped in shell
      screenShell(
        child: const SafeArea(
          child: Center(
            child: Text(
              'Профиль (скоро)',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(gradient: kAppGradient),
        child: Stack(
          children: [
            tabs[_currentIndex],
            // Active filter banner; positioned below header+search so it doesn't overlap
            if (_activeCategory != null)
              Positioned(
                top: 120,
                left: 12,
                right: 12,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _activeSubcategory != null
                                ? 'Фильтр: ${_activeCategory!} › ${_activeSubcategory!}'
                                : 'Фильтр: ${_activeCategory!}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _activeCategory = null;
                              _activeSubcategory = null;
                              _filteredProducts = [];
                            });
                          },
                          child: const Text(
                            'Очистить',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _cart.items,
        builder: (context, Map<int, Map<String, dynamic>> value, _) {
          final count = value.values.fold<int>(
            0,
            (s, e) => s + (e['qty'] as int),
          );

          return Container(
            height: 76 + MediaQuery.of(context).padding.bottom,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6D28D9), Color(0xFFF472B6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.home_filled,
                      label: 'Home',
                      index: 0,
                      isSelected: _currentIndex == 0,
                    ),
                    _buildNavItem(
                      icon: Icons.grid_view_rounded,
                      label: 'Categories',
                      index: 1,
                      isSelected: _currentIndex == 1,
                    ),
                    _buildNavItem(
                      icon: Icons.shopping_cart_rounded,
                      label: 'Cart',
                      index: 2,
                      isSelected: _currentIndex == 2,
                      badge: count > 0 ? count.toString() : null,
                    ),
                    _buildNavItem(
                      icon: Icons.person_rounded,
                      label: 'Profile',
                      index: 3,
                      isSelected: _currentIndex == 3,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    String? badge,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.white70,
                  size: 22,
                ),
                if (badge != null)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
