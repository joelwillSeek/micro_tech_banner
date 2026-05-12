import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'widgets/animated_banner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Window.initialize();
  // await Window.setEffect(effect: WindowEffect.transparent);

  runApp(const MainApp());

  doWhenWindowReady(() {
    const initialSize = Size(510, 190);
    appWindow.minSize = initialSize;
    appWindow.maxSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.bottomRight;
    appWindow.show();

    // Fade in animation
    BannerState.instance.fadeTo(1.0);

    // Hold 3 seconds then fade out
    Future.delayed(const Duration(seconds: 10), () {
      BannerState.instance.fadeTo(0.0);

      // Close the window after fade out animation (400ms) completes
      Future.delayed(const Duration(milliseconds: 500), () {
        appWindow.close();
      });
    });
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
