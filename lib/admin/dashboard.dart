import 'package:flutter/material.dart';
import 'package:intern_system/admin/homepage.dart';
import 'package:intern_system/admin/profilepage.dart';
import 'package:intern_system/admin/pair_users.dart';
import 'package:intern_system/reusablewigets.dart';

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
     final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       body: AnimatedSwitcher(
         duration: const Duration(milliseconds: 200),
         child: _pages[_currentIndex],
       ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryColor,
        onTap: NavigateBottomBar,
        currentIndex: _currentIndex,
         selectedItemColor: Colors.white,
  unselectedItemColor: const Color.fromARGB(255, 184, 209, 221),
  selectedLabelStyle: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: screenWidth*0.0022,
    letterSpacing: 1,
  ),
  unselectedLabelStyle: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: screenWidth*0.002,
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
      Icons.person,
      color: _currentIndex == 1 ? AppColors.primaryColor :AppColors.tertiaryColor,
    ),
  ),
 label: 'Profile',
 
),
BottomNavigationBarItem(
  icon: CircleAvatar(
    backgroundColor: _currentIndex == 2 ? Colors.white : AppColors.backgroundColor,
    child: Icon(
      Icons.supervisor_account,
      color: _currentIndex == 2 ? AppColors.primaryColor : AppColors.tertiaryColor,
    ),
  ),
label: 'pair user',
),
        ]),

    );

  }
}
