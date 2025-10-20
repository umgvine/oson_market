import 'package:flutter/material.dart';
import '../data/data.dart';
import 'home_screen_content.dart' as content;
import '../services/cart_service.dart';
import 'cart_screen.dart';
import '../core/theme.dart';
import '../widgets/search_bar.dart';
// Removed settings/theme toggler; no appThemeMode import needed

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

  // Settings sheet removed along with the old header panel

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
      // Only keep a pinned search bar at the top (removed OSON MARKET header panel)
      return Container(
        decoration: const BoxDecoration(gradient: kAppGradient),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              toolbarHeight: 72,
              flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                child: Container(
                  decoration: const BoxDecoration(gradient: kAppGradient),
                  child: const SafeArea(bottom: false, child: AppSearchBar()),
                ),
              ),
            ),
            SliverFillRemaining(hasScrollBody: true, child: child),
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
              gradient: kAppGradient,
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
