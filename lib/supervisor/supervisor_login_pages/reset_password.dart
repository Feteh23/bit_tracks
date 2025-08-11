import 'package:flutter/material.dart';
import 'package:intern_system/supervisor/supervisor_login_pages/login.dart';

class ResetPassword_supervisor extends StatefulWidget {
  const ResetPassword_supervisor({super.key});

  @override
  State<ResetPassword_supervisor> createState() => ResetPassword_supervisorState();
}

class ResetPassword_supervisorState extends State<ResetPassword_supervisor> {
  bool _ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
  backgroundColor: const Color.fromARGB(255, 114, 26, 20),
  leading:
  IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white,),
    onPressed: () {
      Navigator.pop(context);
    },
  ),

  title: Align(
    child: Text(
      "Bit Tracks Reset Password",
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
      body: Column(
        children: [
           SizedBox(
      height: 40,
    ),
     Image.asset(
    'assets/sitting_on_a_coach.jpg',
     fit: BoxFit.cover,
          ),
           SizedBox(height: 25,),
            Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('Email', style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontSize: 20, fontWeight: FontWeight.bold),),
          )),
        Container(
        height: 50,
          width: 350,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 100, 99, 99),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25, top: 5),
          child: TextField(
            style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: 'fetehmireillelareine@gmail.com',
              border: InputBorder.none,
               hintStyle: TextStyle(color: const Color.fromARGB(255, 172, 172, 172), fontWeight: FontWeight.bold)
            ),
          ),
        ),
        ),
        SizedBox(height: 15,),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('Password', style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontSize: 20, fontWeight: FontWeight.bold),),
          )),

     Row(
       children: [
        SizedBox(
          width: 25,
        ),
         Padding(
           padding: const EdgeInsets.only(left: 5),
           child: Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 100, 99, 99),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
                child:    Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, left: 10),
                    child: TextField(
                      style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontWeight: FontWeight.bold),
                      obscureText: _ischecked,
                      decoration: InputDecoration(
                         border: InputBorder.none,
                         hintText: "....................",
                         hintStyle: TextStyle(color: const Color.fromARGB(255, 185, 181, 181), fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                ),
                 SizedBox(width: 100,),
                    IconButton(onPressed: (){
                      setState(() {
                        _ischecked = !_ischecked;
                      });
                    }, icon: Icon(_ischecked? Icons.visibility_off : Icons.visibility, color: const Color.fromARGB(255, 100, 99, 99),)),
              ],
            ),
               ),
         ),
       ],
     ),
      SizedBox(height: 45,),
         SizedBox(
      height:70,
     ),
    Container(
  height: 50,
  width: 350,
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 100, 99, 99),
    border: Border.all(
      color: Color.fromARGB(255, 100, 99, 99),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(5),
  ),
  child: Padding(
    padding: const EdgeInsets.only(top: 4, left: 10),
    child: Align(
      child: TextButton(onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Login(),
                      ));
        },
        child: Center(child: Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),)),
        
      ),
    ),
  ),
),
        ],
      ),

    );
  }
}