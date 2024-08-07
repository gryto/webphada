import 'package:flutter/material.dart';
import '../launcher/launcher.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WEBPHADA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      routes: {
        '/': (context) => const LauncherPage(),
      },
    );
  }
}
