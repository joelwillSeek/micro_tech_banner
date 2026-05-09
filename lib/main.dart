import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'widgets/animated_banner.dart';

void main() {
  runApp(const MainApp());

  doWhenWindowReady(() async {
    const double bannerWidth = 700;
    const double bannerHeight = 160;

    // Start hidden at height 0
    appWindow.size = const Size(bannerWidth, 0);
    appWindow.alignment = Alignment.bottomRight;
    appWindow.show();

    // Animate height from 0 → bannerHeight over 400ms
    const int steps = 40;
    const Duration stepDuration = Duration(milliseconds: 10);
    for (int i = 1; i <= steps; i++) {
      await Future.delayed(stepDuration);
      final double h = (bannerHeight * i / steps).clamp(0, bannerHeight);
      appWindow.size = Size(bannerWidth, h);
      appWindow.alignment = Alignment.bottomRight;
    }

    // Hold for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Animate height from bannerHeight → 0 over 400ms
    for (int i = steps - 1; i >= 0; i--) {
      await Future.delayed(stepDuration);
      final double h = (bannerHeight * i / steps).clamp(0, bannerHeight);
      appWindow.size = Size(bannerWidth, h);
      appWindow.alignment = Alignment.bottomRight;
    }

    // Exit
    appWindow.close();
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedBanner(),
    );
  }
}
