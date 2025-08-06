import 'package:flutter/material.dart';
import 'package:intern_system/home_pages/homepage.dart';
import 'package:intern_system/home_pages/profilepage.dart';
import 'package:intern_system/home_pages/taskpage.dart';

class Dashborad extends StatefulWidget {
  const Dashborad({super.key});

  @override
  State<Dashborad> createState() => _DashboradState();
}

class _DashboradState extends State<Dashborad> {
   int _currentIndex=0;
  void NavigateBottomBar(int index){
    setState(() {
      _currentIndex=index;
    });
  }
  final List<Widget> _pages =[
Home(),
Profilepage(),
Taskpage(),
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
          BottomNavigationBarItem(icon: CircleAvatar(child: Icon(Icons.task, color: const Color.fromARGB(255, 114, 26, 20),)), label: 'task'),
          BottomNavigationBarItem(icon: CircleAvatar(child: Icon(Icons.person, color: const Color.fromARGB(255, 114, 26, 20),)), label: 'Profile'),
        ]),
    );
  }
}