import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'widgets/animated_banner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    backgroundColor: Colors.transparent,
    skipTaskbar: true,
    size: Size(510, 190),
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    // Make window fully invisible at OS level before showing
    await windowManager.setResizable(false);
    await windowManager.setMaximumSize(const Size(510, 190));
    await windowManager.setOpacity(0.0);

    await windowManager.setAlignment(Alignment.bottomRight);
    await windowManager.show();

    // Wait for OS to resize and reposition
    await Future.delayed(const Duration(milliseconds: 300));

    // Now make window visible at OS level, then fade content in
    await windowManager.setOpacity(1.0);
    BannerState.instance.fadeTo(1.0);
    await Future.delayed(const Duration(milliseconds: 450));

    // Hold 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Fade content out
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
