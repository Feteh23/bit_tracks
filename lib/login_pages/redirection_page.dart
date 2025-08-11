import 'package:flutter/material.dart';
import 'package:intern_system/login_pages/login.dart';
import 'package:intern_system/supervisor/supervisor_login_pages/login.dart';

class RedirectionPage extends StatelessWidget {
  const RedirectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 40, top: 20),
        child: Column(
           mainAxisSize: MainAxisSize.min,
          children: [     
            SizedBox(height: 350,),
             TextButton(onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>Homepage(),
                        ));
          },
          child:  Padding(
            padding: const EdgeInsets.only(right: 25),
            child:Text('Login as an intern', 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 114, 26, 20)),),
          ),
          
        ),
            SizedBox(height: 30,),
             TextButton(onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>Login(),
                        ));
          },
          child:  Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text('Login as a supervisor',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 114, 26, 20)),)
          ),
        ), 
          ],
        ),
      ),
    );
  }
}