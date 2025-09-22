import 'package:flutter/material.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/homepage.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/profilePage.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/taskPage.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class Dashboard_supervisor extends StatefulWidget {
  const Dashboard_supervisor({super.key});

  @override
  State<Dashboard_supervisor> createState() => _Dashboard_supervisorState();
}

class _Dashboard_supervisorState extends State<Dashboard_supervisor> {
  int _currentIndex = 0;
  String? _supervisorUid; // To store the supervisor's UID

  // Initialize the UID when the state is created
  @override
  void initState() {
    super.initState();
    // Get the current user's UID. Assuming the user is already logged in
    // when they reach this dashboard.
    _supervisorUid = FirebaseAuth.instance.currentUser?.uid;
  }

  void NavigateBottomBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Use a getter for _pages so that _supervisorUid is available when accessed
  List<Widget> get _pages {
    // Handle the case where _supervisorUid might be null (e.g., if user isn't logged in)
    // You might want to navigate to a login page or show an error.
    if (_supervisorUid == null) {
      return const [
        Center(child: Text('Error: Supervisor not logged in.')),
        Center(child: Text('Error: Supervisor not logged in.')),
        Center(child: Text('Error: Supervisor not logged in.')),
      ];
    }

    return [
      HomePage_supervisor(),
      SupervisorProfile(),
      SupervisorTask(uid: _supervisorUid!), // PASS THE UID HERE!
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _pages[_currentIndex], // Now uses the getter
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryColor,
        onTap: NavigateBottomBar,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 184, 209, 221),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.0022,
          letterSpacing: 1,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: screenWidth * 0.002,
        ),
        items: [
          // IMPORTANT: The Icon's color should contrast with the CircleAvatar's background
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
      Icons.person,
      color: _currentIndex == 1 ? AppColors.primaryColor : const Color.fromARGB(255, 180, 86, 86),
    ),
  ),
 label: 'Profile',
 
),
BottomNavigationBarItem(
  icon: CircleAvatar(
    backgroundColor: _currentIndex == 2 ? Colors.white : AppColors.backgroundColor,
    child: Icon(
      Icons.task,
      color: _currentIndex == 2 ? AppColors.primaryColor : const Color.fromARGB(255, 180, 86, 86),
    ),
  ),
label: 'task',
),
        ],
      ),
    );
  }
}
