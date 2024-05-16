import 'package:flutter/material.dart';

import 'scan.dart';

void main() {
  runApp(const EdgeDetectionApp());
}

class EdgeDetectionApp extends StatelessWidget {
  const EdgeDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scan(),
    );
  }
}
