import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartService {
  CartService._internal() {
    // не вызываем async тут
  }
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;

  static const _prefsKey = 'oson_cart_v1';

  // key: product id (int), value: {'product': Map<String,dynamic>, 'qty': int}
  final ValueNotifier<Map<int, Map<String, dynamic>>> items =
      ValueNotifier<Map<int, Map<String, dynamic>>>({});

  void _notify() {
    items.value = Map<int, Map<String, dynamic>>.from(items.value);
    _save(); // fire-and-forget
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final toSave = items.value.map(
        (k, v) =>
            MapEntry(k.toString(), {'product': v['product'], 'qty': v['qty']}),
      );
      await prefs.setString(_prefsKey, json.encode(toSave));
    } catch (_) {}
  }

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final s = prefs.getString(_prefsKey);
      if (s == null) return;
      final Map<String, dynamic> parsed =
          json.decode(s) as Map<String, dynamic>;
      final Map<int, Map<String, dynamic>> restored = {};
      parsed.forEach((k, v) {
        final id = int.tryParse(k);
        if (id != null && v is Map<String, dynamic>) {
          restored[id] = {
            'product': Map<String, dynamic>.from(v['product'] as Map),
            'qty': v['qty'] as int,
          };
        }
      });
      items.value = restored;
      // notify listeners by assigning copy
      items.value = Map<int, Map<String, dynamic>>.from(items.value);
    } catch (_) {}
  }

  void add(Map<String, dynamic> product, int qty) {
    final id = product['id'] as int;
    final current = items.value[id];
    if (current != null) {
      current['qty'] = (current['qty'] as int) + qty;
    } else {
      items.value[id] = {'product': product, 'qty': qty};
    }
    _notify();
  }

  void updateQty(int productId, int qty) {
    final current = items.value[productId];
    if (current != null) {
      if (qty <= 0) {
        items.value.remove(productId);
      } else {
        current['qty'] = qty;
      }
      _notify();
    }
  }

  void remove(int productId) {
    if (items.value.containsKey(productId)) {
      items.value.remove(productId);
      _notify();
    }
  }

  void clear() {
    items.value.clear();
    _notify();
  }

  int get totalItems {
    return items.value.values.fold<int>(0, (s, e) => s + (e['qty'] as int));
  }

  double get totalPrice {
    double sum = 0;
    items.value.forEach((k, v) {
      final p = v['product']['price'];
      final qty = v['qty'] as int;
      if (p is num) sum += p.toDouble() * qty;
    });
    return sum;
  }
}
