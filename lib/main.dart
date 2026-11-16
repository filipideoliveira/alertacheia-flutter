import 'dart:ui';

import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AlertaCheiaApp());
}

class AlertaCheiaApp extends StatelessWidget {
  const AlertaCheiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertaCheia',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      // No Chrome, deixa arrastar as listas horizontais com o mouse.
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      home: const HomeScreen(),
    );
  }
}
