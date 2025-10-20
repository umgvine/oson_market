// Mahsulotlar uchun API servisi (mock)

import '../models/product.dart';

class ProductService {
  // Bu yerda backenddan yoki lokal mockdan ma'lumot olinadi
  Future<List<Product>> fetchProducts() async {
    // Hozircha mock ma'lumot
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Product(
        id: '1',
        name: 'Smart soat Series 7',
        description: 'Yangi avlod smart soat',
        price: 899000,
        imageUrl: 'assets/demo/demo_product.png',
      ),
      // ... boshqa mahsulotlar ...
    ];
  }
}