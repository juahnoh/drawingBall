import 'package:draw/screens/drawing_page/drawing_page.dart';
import 'package:draw/screens/drawing_page/local_utils/DrawingProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context)=> DrawingProvider(),
          child: DrawingPage()),
    );
  }
}

