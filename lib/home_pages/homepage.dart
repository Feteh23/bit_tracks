import 'package:flutter/material.dart';
import 'package:intern_system/home_pages/attendance.dart';
import 'package:intern_system/home_pages/dashborad.dart';
import 'package:intern_system/home_pages/profilepage.dart';
import 'package:intern_system/home_pages/supervisor.dart';
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
      "Intern Dashboard",
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
                           builder: (BuildContext context) => Dashborad(),
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
                            builder: (BuildContext context) => Taskpage(),
                          ));
                           },
                             child: CircleAvatar(radius: 15,child: Icon(Icons.task, color: const Color.fromARGB(255, 114, 26, 20),),)
                           
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
                            builder: (BuildContext context) => Supervisor(),
                          ));
                           },
                              child: CircleAvatar(radius: 15,child: Icon(Icons.supervisor_account, color: const Color.fromARGB(255, 114, 26, 20),),),
                           
                         ),
                  SizedBox(width: 30,),
                  Text('Supervisor', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
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
                            builder: (BuildContext context) => Attendance(),
                          ));
                           },
                              child: CircleAvatar(radius: 15,child: Icon(Icons.check_box, color: const Color.fromARGB(255, 114, 26, 20),),),
                           
                         ),
                  SizedBox(width: 30,),
                  Text('Attendance', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
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
     body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
       child: Column(
        
        children: [
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // Dashboard Summary
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       _buildSummaryCard('20', 'Interns'),
                       _buildSummaryCard('5', 'Departments'),
                       _buildSummaryCard('2', 'Upcoming Deadlines'),
                     ],
                   ),
                 ),
                 SizedBox(height: 20),
                 // Intern Directory
                 SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                   child: Column(
                     children: [
                       Text('Intern Directory', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                   SizedBox(height: 10),
                   _buildInternCard('Feteh Mireille', 'mobile dev', 'fetehmireille@gmail.com'),
                   _buildInternCard('Nyanga piethras', 'front end', 'piethrasn@gmail.com'),
                   _buildInternCard('Mimber prescienne', 'back end', 'mimber@gmail.com'),
                   _buildInternCard('tekum silvia', 'full stack', 'silvia@gmail.com'),
                   SizedBox(height: 20),
                   // Task Management
                   Text('Task Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                   SizedBox(height: 10),
                   _buildTaskCard('Assign Project X', 0.7, Colors.orange),
                   _buildTaskCard('Review Reports', 0.5, Colors.blue),
                   _buildTaskCard('Fix Website Bug', 0.3, Colors.grey),
                   SizedBox(height: 20),
                   // Notifications
                   Text('Notifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                   SizedBox(height: 10),
                   _buildNotificationCard('Feteh Mireille has been onboarded'),
                   _buildNotificationCard('New task assigned: Update...'),
                   _buildNotificationCard('Deadline tomorrow for Internship Reports'),
                                ],
                     
                   ),
                 ),
       
         ] ),
           )
           ]
           ),
     )
    );
  }

  Widget _buildSummaryCard(String count, String label) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(label, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildInternCard(String name, String department, String email) {
    return Card(
      child: ListTile(
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(department),
            Text(email),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(String task, double progress, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              color: color,
              backgroundColor: color.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String notification) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.red),
        title: Text(notification),
      ),
    );
  }
}
