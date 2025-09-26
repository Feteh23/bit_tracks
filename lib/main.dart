import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intern_system/Intern/dashborad.dart';
import 'firebase_options.dart';

import 'package:intern_system/login_pages/welcomepage.dart';
import 'package:intern_system/admin/dashboard.dart';
import 'package:intern_system/supervisor/supervisor/dashboard.dart';
import 'package:intern_system/authGate.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      routes: {
        '/adminDashboard': (context) => AdminDashboar(),
        '/supervisorDashboard': (context) => Dashboard_supervisor(),
        '/internDashboard': (context) => Dashborad(),
      },
    );
  }
}

