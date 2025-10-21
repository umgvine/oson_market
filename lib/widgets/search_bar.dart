import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // Make the search bar semi-transparent (shafof)
        color: Colors.white.withOpacity(0.12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          hintText: 'YA Market’da qidirish',
          hintStyle: TextStyle(
            color: Colors.white70,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: const Icon(Icons.search, size: 20, color: Colors.white70),
          filled: true,
          // Match the container's semi-transparent fill
          fillColor: Colors.white.withOpacity(0.06),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
