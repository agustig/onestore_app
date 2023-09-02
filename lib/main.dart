import 'package:flutter/material.dart';
import 'package:flutter_store_fic7/pages/auth/auth_page.dart';
import 'package:flutter_store_fic7/utils/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: light,
      home: const AuthPage(),
    );
  }
}
