import 'package:flutter/material.dart';
import 'package:intern_system/home_pages/dashborad.dart';
import 'package:intern_system/home_pages/profilepage.dart';
import 'package:intern_system/home_pages/taskpage.dart';
import 'package:intern_system/login_pages/login.dart';
class Home extends StatelessWidget {
  const Home({super.key});

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
      "Bit Tracks",
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
                       builder: (BuildContext context) => Dashborad(),
                     ));
                      },
                        child: CircleAvatar(child: Icon(Icons.close), radius: 15,),
                      
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
                           builder: (BuildContext context) => Dashborad(),
                         ));
                          },
                            child: CircleAvatar(child: Icon(Icons.house, color: const Color.fromARGB(255, 114, 26, 20),), radius: 15,)
                          
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
                            builder: (BuildContext context) => Taskpage(),
                          ));
                           },
                             child: CircleAvatar(child: Icon(Icons.task, color: const Color.fromARGB(255, 114, 26, 20),), radius: 15,)
                           
                         ),
                  SizedBox(width: 30,),
                  Text('task', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
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
                            builder: (BuildContext context) => Profilepage(),
                          ));
                           },
                              child: CircleAvatar(child: Icon(Icons.person, color: const Color.fromARGB(255, 114, 26, 20),), radius: 15,),
                           
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
                           builder: (BuildContext context) => Homepage(),
                         ));
                          },
                            child: CircleAvatar(child: Icon(Icons.logout, color: const Color.fromARGB(255, 114, 26, 20),), radius: 15,)
                          
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