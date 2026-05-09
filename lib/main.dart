import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'widgets/animated_banner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(520, 160),
    backgroundColor: Colors.transparent,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAlignment(Alignment.bottomRight);
    await windowManager.setResizable(false);
    await windowManager.show();

    // Print actual window size so we can see what the OS reports
    final size = await windowManager.getSize();
    debugPrint('>>> actual window size: $size');

    // Short delay for the OS to finish positioning
    await Future.delayed(const Duration(milliseconds: 200));

    // Fade in
    BannerState.instance.fadeTo(1.0);
    await Future.delayed(const Duration(milliseconds: 450));

    // Hold 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Fade out
    BannerState.instance.fadeTo(0.0);
    await Future.delayed(const Duration(milliseconds: 450));

    await windowManager.close();
  });

  runApp(const MainApp());
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
