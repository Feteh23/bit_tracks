import 'package:flutter/material.dart';
import 'package:intern_system/Intern/homepage.dart';
import 'package:intern_system/Intern/taskpage.dart';
import 'package:intern_system/Intern/profilepage.dart';
import 'package:intern_system/reusablewigets.dart';
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
    fontSize: screenWidth*0.015,
    letterSpacing: 1,
  ),
  unselectedLabelStyle: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: screenWidth*0.01,
  ),

        items: [
            BottomNavigationBarItem(
  icon: CircleAvatar(
    backgroundColor: _currentIndex == 0 ? Colors.white : AppColors.backgroundColor,
    child: Icon(
      Icons.home,
      color: _currentIndex == 0 ? AppColors.primaryColor : AppColors.tertiaryColor,
    ),
  ),
  label: 'Home',
),
BottomNavigationBarItem(
  icon: CircleAvatar(
    backgroundColor: _currentIndex == 1 ? Colors.white : AppColors.backgroundColor,
    child: Icon(
      Icons.task,
      color: _currentIndex == 1 ? AppColors.primaryColor :AppColors.tertiaryColor,
    ),
  ),
 label: 'task',
 
),
BottomNavigationBarItem(
  icon: CircleAvatar(
    backgroundColor: _currentIndex == 2 ? Colors.white : AppColors.backgroundColor,
    child: Icon(
      Icons.person,
      color: _currentIndex == 2 ? AppColors.primaryColor : AppColors.tertiaryColor,
    ),
  ),
label: 'profile',
)
        ]),
    );
  }
}