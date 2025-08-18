import 'package:flutter/material.dart';
import 'package:intern_system/login_pages/login.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/dashboard.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/profilePage.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/taskPage.dart';


class HomePage_supervisor extends StatefulWidget {
  const HomePage_supervisor({super.key});

  @override
  State<HomePage_supervisor> createState() => _HomePage_supervisorState();
}

class _HomePage_supervisorState extends State<HomePage_supervisor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: const Color.fromARGB(255, 114, 26, 20),
  leading:
   Builder(builder: (BuildContext context) {
          return IconButton(onPressed: (){Scaffold.of(context).openDrawer();}, icon: Icon(Icons.menu), color: Colors.white, iconSize: 38,);
        }),
  title: Align(
    child: Text(
      "Supervisor Dashboard",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.book_online_outlined, color: Colors.white),
      onPressed: () {
        // Add your action here
      },
    ),
  ],
),
 drawer: Drawer(
      child: Container(
        color: const Color.fromARGB(255, 114, 26, 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 220),
              child: TextButton(onPressed: (){
                     Navigator.push(context,
                     MaterialPageRoute(
                       builder: (BuildContext context) => Dashboard_supervisor(),
                     ));
                      },
                        child: CircleAvatar(radius: 15,child: Icon(Icons.close),),
                      
                    ),
            ),
            SizedBox(height: 70,),
           Padding(
             padding: const EdgeInsets.only(left: 25),
             child: Text('Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white,),),
           ),
            SizedBox(height: 10,),
            Divider(
              thickness: 2, 
              color: Colors.white,
            ),
             SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  TextButton(onPressed: (){
                         Navigator.push(context,
                         MaterialPageRoute(
                           builder: (BuildContext context) => Dashboard_supervisor(),
                         ));
                          },
                            child: CircleAvatar(radius: 15,child: Icon(Icons.house, color: const Color.fromARGB(255, 114, 26, 20),),)
                          
                        ),
                  SizedBox(width: 30,),
                  Text('Home', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                ],
              ),
            ),
             SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  TextButton(onPressed: (){
                          Navigator.push(context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SupervisorTask(),
                          ));
                           },
                             child: CircleAvatar(radius: 15,child: Icon(Icons.task, color: const Color.fromARGB(255, 114, 26, 20),),)
                           
                         ),
                  SizedBox(width: 30,),
                  Text('create a tasks', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                ],
              ),
            ),
             SizedBox(height: 40,),
             Padding(
               padding: const EdgeInsets.only(left: 15),
               child: Row(
                children: [
                  TextButton(onPressed: (){
                          Navigator.push(context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SupervisorProfile(),
                          ));
                           },
                              child: CircleAvatar(radius: 15,child: Icon(Icons.person, color: const Color.fromARGB(255, 114, 26, 20),),),
                           
                         ),
                  SizedBox(width: 30,),
                  Text('Account', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                ],
                           ),
             ),
               SizedBox(height: 40,),
             Padding(
               padding: const EdgeInsets.only(left: 15),
               child: Row(
                children: [
                  TextButton(onPressed: (){
                          Navigator.push(context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Dashboard_supervisor(),
                          ));
                           },
                              child: CircleAvatar(radius: 15,child: Icon(Icons.supervisor_account, color: const Color.fromARGB(255, 114, 26, 20),),),
                           
                         ),
                  SizedBox(width: 30,),
                  Text('intern list', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                ],
                           ),
             ),
             SizedBox(height: 40,),
             Padding(
               padding: const EdgeInsets.only(left: 15),
               child: Row(
                children: [
                  TextButton(onPressed: (){
                          Navigator.push(context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Dashboard_supervisor(),
                          ));
                           },
                              child: CircleAvatar(radius: 15,child: Icon(Icons.check_box, color: const Color.fromARGB(255, 114, 26, 20),),),
                           
                         ),
                  SizedBox(width: 30,),
                  Text(' track intern Attendance', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                ],
                           ),
             ),
             SizedBox(height: 40,),
             
              Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  TextButton(onPressed: (){
                         Navigator.push(context,
                         MaterialPageRoute(
                           builder: (BuildContext context) => Homepage(),
                         ));
                          },
                            child: CircleAvatar(radius: 15,child: Icon(Icons.logout, color: const Color.fromARGB(255, 114, 26, 20),),)
                          
                        ),
                  SizedBox(width: 30,),
                  Text('logout', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                ],
              ),
            ),
             
          ],
        ),
      ),
     ) ,

    );
  }
}