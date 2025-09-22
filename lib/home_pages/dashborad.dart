import 'package:flutter/material.dart';
import 'package:intern_system/home_pages/homepage.dart';
import 'package:intern_system/home_pages/taskpage.dart';
import 'package:intern_system/home_pages/profilepage.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';
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
Taskpage(),
Profilepage(),
  ];
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
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
            BottomNavigationBarItem(
  icon: CircleAvatar(
    backgroundColor: _currentIndex == 0 ? Colors.white : AppColors.backgroundColor,
    child: Icon(
      Icons.home,
      color: _currentIndex == 0 ? AppColors.primaryColor : const Color.fromARGB(255, 180, 86, 86),
    ),
  ),
  label: 'Home',
),
BottomNavigationBarItem(
  icon: CircleAvatar(
    backgroundColor: _currentIndex == 1 ? Colors.white : AppColors.backgroundColor,
    child: Icon(
      Icons.task,
      color: _currentIndex == 1 ? AppColors.primaryColor :const Color.fromARGB(255, 180, 86, 86),
    ),
  ),
 label: 'task',
 
),
BottomNavigationBarItem(
  icon: CircleAvatar(
    backgroundColor: _currentIndex == 2 ? Colors.white : AppColors.backgroundColor,
    child: Icon(
      Icons.person,
      color: _currentIndex == 2 ? AppColors.primaryColor : const Color.fromARGB(255, 180, 86, 86),
    ),
  ),
label: 'profile',
)
        ]),
    );
  }
}