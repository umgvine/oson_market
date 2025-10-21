import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  final Function(String)? onSearchChanged;
  final String? hintText;
  final bool enabled;

  const AppSearchBar({
    super.key,
    this.onSearchChanged,
    this.hintText,
    this.enabled = true,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {}); // Rebuild to show/hide clear button
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // Make the search bar semi-transparent (shafof)
        color: Colors.white.withValues(alpha: 0.12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        style: const TextStyle(fontSize: 15, color: Colors.white),
        onChanged: (value) {
          widget.onSearchChanged?.call(value);
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          hintText: widget.hintText ?? 'YA Market\'da qidirish',
          hintStyle: TextStyle(
            color: Colors.white70,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: const Icon(Icons.search, size: 20, color: Colors.white70),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    size: 18,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    _controller.clear();
                    widget.onSearchChanged?.call('');
                    _focusNode.unfocus();
                  },
                )
              : null,
          filled: true,
          // Match the container's semi-transparent fill
          fillColor: Colors.white.withValues(alpha: 0.06),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
