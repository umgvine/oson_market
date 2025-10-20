import 'package:flutter/material.dart';
import '../core/theme.dart';

class HeaderBar extends StatelessWidget {
  final VoidCallback? onProfile;
  final VoidCallback? onSettings;
  const HeaderBar({super.key, this.onProfile, this.onSettings});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: kAppGradient),
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            // subtle bottom divider shadow effect
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 0,
                offset: Offset(0, 0.2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'OSON MARKET',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    height: 1.0,
                    letterSpacing: 0.5,
                    fontFamily: 'Gagalin',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Profile button
              InkWell(
                onTap: onProfile,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                    border: Border.all(color: Colors.white30, width: 1),
                  ),
                  child: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 10),
              // Settings button
              InkWell(
                onTap: onSettings,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                    border: Border.all(color: Colors.white30, width: 1),
                  ),
                  child: const Icon(Icons.settings, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
