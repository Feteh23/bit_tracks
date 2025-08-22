import 'package:flutter/material.dart';
import 'package:intern_system/admin/homepage.dart';
import 'package:intern_system/admin/profilepage.dart';
import 'package:intern_system/admin/pair_users.dart';

class AdminDashboar extends StatefulWidget {
  const AdminDashboar({super.key});

  @override
  State<AdminDashboar> createState() => _AdminDashboarState();
}

class _AdminDashboarState extends State<AdminDashboar> {
    int _currentIndex=0;
  void NavigateBottomBar(int index){
    setState(() {
      _currentIndex=index;
    });
  }
  final List<Widget> _pages =[
    AdminHomepage(),
    Adminprofilepage(),
    AdminPairUserspage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 114, 26, 20),
        onTap: NavigateBottomBar,
        currentIndex: _currentIndex,
         selectedItemColor: Colors.white,
  unselectedItemColor: const Color.fromARGB(255, 184, 209, 221),
  selectedLabelStyle: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    letterSpacing: 1,
  ),
  unselectedLabelStyle: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
  ),

        items: [
          BottomNavigationBarItem(icon: CircleAvatar(child: Icon(Icons.home, color: const Color.fromARGB(255, 114, 26, 20),)), label: 'Home'  ),
          BottomNavigationBarItem(icon: CircleAvatar(child: Icon(Icons.person, color: const Color.fromARGB(255, 114, 26, 20),)), label: 'Profile'),
          BottomNavigationBarItem(icon: CircleAvatar(child: Icon(Icons.supervisor_account, color: const Color.fromARGB(255, 114, 26, 20),)), label: 'pair user'),
        ]),

    );

  }
}
