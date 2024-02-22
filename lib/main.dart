import 'dart:js';

import 'package:flutter/material.dart';
import 'package:machine_test_opine/controller/product_controller.dart';
import 'package:machine_test_opine/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductController(),
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: CategoryDisplay(),
    );
  }
}
