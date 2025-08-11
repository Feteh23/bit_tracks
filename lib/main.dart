import 'package:flutter/material.dart';
import 'package:intern_system/login_pages/welcomepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Welcomepage(
        
      ),
    );
  }
}