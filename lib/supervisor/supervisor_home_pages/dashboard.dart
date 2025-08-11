import 'package:flutter/material.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/homepage.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/profilePage.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/taskPage.dart';

class Dashboard_supervisor extends StatefulWidget {
  const Dashboard_supervisor({super.key});

  @override
  State<Dashboard_supervisor> createState() => _Dashboard_supervisorState();
}

class _Dashboard_supervisorState extends State<Dashboard_supervisor> {
  int _currentIndex=0;
  void NavigateBottomBar(int index){
    setState(() {
      _currentIndex=index;
    });
  }
  final List<Widget> _pages =[
    HomePage_supervisor(),
    SupervisorProfile(),
    SupervisorTask(),
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
          BottomNavigationBarItem(icon: CircleAvatar(child: Icon(Icons.task, color: const Color.fromARGB(255, 114, 26, 20),)), label: 'create a task'),
        ]),

    );
  }
}