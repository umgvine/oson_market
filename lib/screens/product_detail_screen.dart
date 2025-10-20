import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback onAddToCart;

  const ProductDetailScreen({
    required this.product,
    required this.onAddToCart,
    super.key,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  int quantity = 1;
  int currentImageIndex = 0;
  bool isFavorite = false;
  late final TabController _tabController;

  // Helper: call existing VoidCallback `onAddToCart` multiple times.
  // We keep the existing API (VoidCallback) to avoid breaking other call sites.
  void _addToCartTimes(int times) {
    final safe = times.clamp(1, 99);
    for (int i = 0; i < safe; i++) {
      widget.onAddToCart();
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final gallery =
        (product['gallery'] as List?)?.cast<String>() ??
        ['assets/demo/demo_product.png'];

    final price = product['price'] ?? 0;
    final oldPrice = product['oldPrice'];
    final discount = product['discount'];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          product['name'] ?? '',
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
            ),
            onPressed: () => setState(() => isFavorite = !isFavorite),
          ),
        ],
      ),
      body: Column(
        children: [
          // Gallery
          SizedBox(
            height: 260,
            width: double.infinity,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: gallery.length,
                  onPageChanged: (i) => setState(() => currentImageIndex = i),
                  itemBuilder: (context, index) => Hero(
                    tag: 'product_${product['id']}',
                    child: Image.asset(
                      gallery[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (c, e, s) =>
                          Container(color: Colors.grey.shade800),
                    ),
                  ),
                ),
                if (gallery.length > 1)
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        gallery.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentImageIndex == i ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentImageIndex == i
                                ? Colors.white
                                : Colors.white24,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Details area
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF121214),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // header: price + rating
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (discount != null && discount > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '-$discount%',
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 8),
                              Text(
                                '$price UZS',
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              if (oldPrice != null)
                                Text(
                                  '$oldPrice UZS',
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${product['rating'] ?? 0}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Доставка: ${product['deliveryDate'] ?? '-'}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Tabs
                  TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: 'Описание'),
                      Tab(text: 'Характеристики'),
                      Tab(text: 'Доставка'),
                    ],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),

                  // Tab content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            child: Text(
                              product['desc'] ?? '',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Характеристики',
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Доставка и возврат',
                              style: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom CTA row — green wide button on left, stepper on right (matches screenshots)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Row(
                      children: [
                        // CTA green button (two lines)
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF29C36A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                // Поведение: вариант A — вызываем колбэк `onAddToCart` N раз,
                                // где N = quantity. Это простой подход, не меняющий сигнатуру
                                // существующего колбэка (VoidCallback). Если потом захотите
                                // изменить API, можно заменить `onAddToCart` на
                                // ValueChanged<int> и передавать количество одним вызовом.
                                _addToCartTimes(quantity);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Добавлено $quantity'),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'В корзину',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    product['cartDate'] ?? '7 октября',
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Stepper on right
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1C),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                                onPressed: () => setState(() {
                                  if (quantity > 1) quantity--;
                                }),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () => setState(() {
                                  quantity++;
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
