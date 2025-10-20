import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget child;

  const ResponsiveWidget({super.key, required this.child});

  static bool isMobile(BuildContext context) => 
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) => 
      MediaQuery.of(context).size.width >= 600 && 
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) => 
      MediaQuery.of(context).size.width >= 1200;

  static double getResponsiveValue(BuildContext context, 
      {double mobile = 1.0, double tablet = 1.2, double desktop = 1.5}) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: constraints.maxWidth,
          ),
          child: child,
        );
      },
    );
  }
}
