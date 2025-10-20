// admin_categories_screen.dart
import 'package:flutter/material.dart';

class AdminCategoriesScreen extends StatefulWidget {
  const AdminCategoriesScreen({super.key});

  @override
  State<AdminCategoriesScreen> createState() => _AdminCategoriesScreenState();
}

class _AdminCategoriesScreenState extends State<AdminCategoriesScreen> {
  final List<Map<String, dynamic>> _categories = [
    {
      'id': '1',
      'name': 'Elektronika',
      'subcategories': 8,
      'products': 124,
      'icon': Icons.phone_iphone,
      'color': Colors.blue,
    },
    {
      'id': '2',
      'name': 'Kiyimlar',
      'subcategories': 5,
      'products': 87,
      'icon': Icons.checkroom,
      'color': Colors.purple,
    },
    {
      'id': '3',
      'name': 'Poyabzallar',
      'subcategories': 4,
      'products': 56,
      'icon': Icons.shopping_bag,
      'color': Colors.orange,
    },
    {
      'id': '4',
      'name': 'Aksesuarlar',
      'subcategories': 6,
      'products': 92,
      'icon': Icons.watch,
      'color': Colors.green,
    },
    {
      'id': '5',
      'name': 'Kosmetika',
      'subcategories': 3,
      'products': 45,
      'icon': Icons.spa,
      'color': Colors.pink,
    },
    {
      'id': '6',
      'name': 'Uy uchun',
      'subcategories': 7,
      'products': 78,
      'icon': Icons.home,
      'color': Colors.brown,
    },
  ];

  void _addCategory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yangi kategoriya'),
        content: const TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Kategoriya nomi',
            hintText: 'Masalan: Oziq-ovqat',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('BEKOR QILISH'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Yangi kategoriya qo\'shildi')),
              );
            },
            child: const Text('QO\'SHISH'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kategoriyani o\'chirish'),
        content: const Text('Bu kategoriyani rostdan ham o\'chirmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('BEKOR QILISH'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _categories.removeWhere((c) => c['id'] == id));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kategoriya o\'chirildi')),
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
        onPressed: _addCategory,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return Card(
            elevation: 2,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: category['color'].withAlpha(
                        (0.2 * 255).round(),
                      ),
                      child: Icon(
                        category['icon'],
                        size: 30,
                        color: category['color'],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      category['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Chip(
                          label: Text('${category['subcategories']} ta turkum'),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text('${category['products']} ta mahsulot'),
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                          onPressed: () => _deleteCategory(category['id']),
                        ),
                      ],
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
}
