// Clean, compact ProductCard implementation.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/responsive_widget.dart';

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onAddToCart;
  final ValueChanged<int>? onAddWithQuantity;
  final VoidCallback? onFavorite;

  const ProductCard({
    required this.product,
    this.onAddToCart,
    this.onAddWithQuantity,
    this.onFavorite,
    super.key,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 1;
  // (favorite state removed for now to keep file lint-clean)

  void _inc() => setState(() => _quantity = (_quantity + 1).clamp(1, 99));
  void _dec() => setState(() => _quantity = (_quantity - 1).clamp(1, 99));

  String _formatPrice(dynamic p) {
    if (p == null) return '';
    try {
      final numValue = p is num ? p : num.parse(p.toString());
      return NumberFormat.decimalPattern().format(numValue);
    } catch (_) {
      return p.toString();
    }
  }

  Widget _buildStars(double rating) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;
    final widgets = <Widget>[];
    for (var i = 0; i < full; i++) {
      widgets.add(const Icon(Icons.star, size: 12, color: Colors.amber));
    }
    if (half) {
      widgets.add(const Icon(Icons.star_half, size: 12, color: Colors.amber));
    }
    while (widgets.length < 5) {
      widgets.add(const Icon(Icons.star_border, size: 12, color: Colors.amber));
    }
    return Row(mainAxisSize: MainAxisSize.min, children: widgets);
  }

  void _openDetail() {
    final img = widget.product['img'] as String?;
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(widget.product['name'] ?? 'Product')),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (img != null)
                    Hero(
                      tag: 'product_${widget.product['id']}',
                      child: Image.asset(
                        img,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(height: 200, color: Colors.grey.shade200),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    widget.product['name'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: _buildStars(
                          (widget.product['rating'] ?? 0).toDouble(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '(${widget.product['reviews'] ?? 0})',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(widget.product['desc'] ?? ''),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onAddWithQuantity?.call(_quantity);
                        widget.onAddToCart?.call();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Добавлено $_quantity шт.')),
                        );
                      },
                      child: const Text('Добавить в корзину'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final img = product['img'] as String?;
    final price = product['price'];
    final old = product['oldPrice'];
    final isMobile = ResponsiveWidget.isMobile(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _openDetail,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: img != null
                  ? Image.asset(
                      img,
                      height: isMobile ? 88 : 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: isMobile ? 88 : 120,
                        color: Colors.grey.shade200,
                      ),
                    )
                  : Container(
                      height: isMobile ? 88 : 120,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${_formatPrice(price)} so\'m',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      if (old != null) const SizedBox(width: 8),
                      if (old != null)
                        Flexible(
                          child: Text(
                            '${_formatPrice(old)} so\'m',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product['seller'] ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product['deliveryDate'] ?? '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 56,
                            minWidth: 0,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: _dec,
                                    child: const Icon(Icons.remove, size: 14),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Text(
                                      '$_quantity',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _inc,
                                    child: const Icon(Icons.add, size: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onAddWithQuantity?.call(_quantity);
                            widget.onAddToCart?.call();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Добавлено $_quantity шт.'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha((0.08 * 255).round()),
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            minimumSize: const Size.fromHeight(40),
                          ),
                          child: const Text("Savatga qo'shish"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
