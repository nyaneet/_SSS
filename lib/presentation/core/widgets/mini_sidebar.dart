import 'package:flutter/material.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';

/// A mini sideba
/// Could be a company logo or something else
/// todo: actual implementation
class MiniSidebar extends StatelessWidget {
  const MiniSidebar({super.key, required this.child});

  ///
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final padding = const Setting('padding').toDouble;
    final blockHeight = const Setting('infoSidebarHeight').toDouble;
    // final cardElevation = const Setting('cardElevation').toDouble;
    return Hero(
      tag: 'info_sidebar',
      child: SizedBox(
        height: blockHeight,
        width: blockHeight,
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
