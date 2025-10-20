// admin_products_screen.dart
import 'package:flutter/material.dart';
import 'admin_product_edit_screen.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Smart soat Series 7',
      'category': 'Elektronika',
      'price': '899,000 so\'m',
      'stock': 42,
      'status': 'Faol',
      'created': '2023-10-15',
    },
    {
      'id': '2',
      'name': 'Designer Bag',
      'category': 'Kiyimlar',
      'price': '459,000 so\'m',
      'stock': 18,
      'status': 'Faol',
      'created': '2023-10-10',
    },
    {
      'id': '3',
      'name': 'Summer Shoes',
      'category': 'Poyabzallar',
      'price': '249,000 so\'m',
      'stock': 0,
      'status': 'Zahira tugagan',
      'created': '2023-10-05',
    },
    {
      'id': '4',
      'name': 'Jewelry Set',
      'category': 'Aksesuarlar',
      'price': '299,000 so\'m',
      'stock': 7,
      'status': 'Faol',
      'created': '2023-09-28',
    },
  ];

  void _addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminProductEditScreen(
          product: null,
          onSave: (newProduct) {
            setState(() => _products.insert(0, newProduct));
          },
        ),
      ),
    );
  }

  void _editProduct(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminProductEditScreen(
          product: product,
          onSave: (updatedProduct) {
            setState(() {
              final index = _products.indexWhere(
                (p) => p['id'] == product['id'],
              );
              if (index != -1) _products[index] = updatedProduct;
            });
          },
        ),
      ),
    );
  }

  void _deleteProduct(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mahsulotni o\'chirish'),
        content: const Text('Bu mahsulotni rostdan ham o\'chirmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('BEKOR QILISH'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _products.removeWhere((p) => p['id'] == id));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mahsulot o\'chirildi')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('O\'CHIRISH'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Mahsulotlarni qidirish...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Image.asset(
                      product['img'] ?? 'assets/placeholders/placeholder.png',
                      width: 50,
                      errorBuilder: (c, e, s) =>
                          const Icon(Icons.image, size: 40),
                    ),
                    title: Text(product['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product['category']),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(product['price']),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: product['stock'] > 0
                                    ? Colors.green.shade100
                                    : Colors.red.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product['stock'] > 0
                                    ? '${product['stock']} ta qoldi'
                                    : 'Zahira tugadi',
                                style: TextStyle(
                                  color: product['stock'] > 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editProduct(product),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProduct(product['id']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
