import 'package:flutter/material.dart';
import '../data/data.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategoriyalar')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final cat = categories[i];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: Image.asset(
                cat['img'] as String,
                width: 48,
                height: 48,
                errorBuilder: (c, e, s) => const Icon(Icons.category),
              ),
              title: Text(
                cat['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SubCategoryScreen(category: cat),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SubCategoryScreen extends StatelessWidget {
  final Map<String, dynamic> category;
  const SubCategoryScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final subs = category['subcategories'] as List;
    return Scaffold(
      appBar: AppBar(title: Text(category['name'])),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 14,
          mainAxisSpacing: 18,
        ),
        itemBuilder: (ctx, i) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  subs[i]['img'] as String,
                  width: 60,
                  height: 60,
                  errorBuilder: (c, e, s) => const Icon(Icons.image),
                ),
                const SizedBox(height: 10),
                Text(subs[i]['name'], textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
