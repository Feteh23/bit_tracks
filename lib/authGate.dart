import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intern_system/login_pages/welcomepage.dart';
import 'package:intern_system/admin/dashboard.dart';
import 'package:intern_system/supervisor/supervisor/dashboard.dart';
import 'package:intern_system/Intern/dashborad.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 🔒 Not logged in
        if (!snapshot.hasData) {
          return Welcomepage();
        }

        // ✅ Logged in — fetch role from Firestore
        final uid = snapshot.data!.uid;
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
              return const Center(child: Text('User data not found.'));
            }

            final role = userSnapshot.data!['role'];
            switch (role) {
              case 'admin':
                return AdminDashboar();
              case 'supervisor':
                return Dashboard_supervisor();
              case 'intern':
                return Dashborad();
              default:
                return const Center(child: Text('Unknown role.'));
            }
          },
        );
      },
    );
  }
}
