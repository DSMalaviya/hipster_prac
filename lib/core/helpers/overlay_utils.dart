import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverlayUtils {
  static OverlayEntry? _overlayEntry;

  /// Show overlay
  static void showOverlay() {
    if (_overlayEntry != null) return; // Prevent multiple overlays

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Material(color: Colors.black.withValues(alpha: 0.1)),
      ),
    );

    Overlay.of(Get.overlayContext!, rootOverlay: true).insert(_overlayEntry!);
  }

  /// Hide overlay
  static void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// Check if overlay is active
  static bool get isVisible => _overlayEntry != null;
}
