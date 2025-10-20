import 'package:flutter/material.dart';
import 'package:ya_market/core/widgets/responsive_widget.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final bool isRussian;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isRussian,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: ResponsiveWidget.isMobile(context) ? 60 : 80,
            height: ResponsiveWidget.isMobile(context) ? 60 : 80,
            decoration: BoxDecoration(
              color: category['color'].withAlpha((0.1 * 255).round()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              category['icon'],
              size: ResponsiveWidget.isMobile(context) ? 30 : 40,
              color: category['color'],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isRussian ? category['name_ru'] : category['name_uz'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveWidget.isMobile(context) ? 12 : 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
