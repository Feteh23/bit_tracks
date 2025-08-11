import 'package:flutter/material.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/dashboard.dart';

class Signup_Supervisor extends StatefulWidget {
  const Signup_Supervisor({super.key});

  @override
  State<Signup_Supervisor> createState() => _SignupState();
}

class _SignupState extends State<Signup_Supervisor> {
   bool _ischecked = true;
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
      "Bit Tracks SignUp",
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
      height: 20,
    ),
     Image.asset(
    'assets/typing_girl.jpg',
     fit: BoxFit.cover,
          ),
           SizedBox(height: 25,),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('Name', style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontSize: 20, fontWeight: FontWeight.bold),),
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
                child:    Expanded(
                  child: Padding(
           padding: const EdgeInsets.only(top: 4, left: 10),
           child: TextField(
             style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontWeight: FontWeight.bold),
             decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Feteh Mireille",
                hintStyle: TextStyle(color: const Color.fromARGB(255, 192, 190, 190), fontWeight: FontWeight.bold)
             ),
           ),
                  ),
                ),
               ),
         ),
       ],
     ),
       Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('Email', style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontSize: 20, fontWeight: FontWeight.bold),),
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
                child:    Expanded(
                  child: Padding(
           padding: const EdgeInsets.only(top: 4, left: 10),
           child: TextField(
             style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontWeight: FontWeight.bold),
             decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "fetehmireillelareine@gmail.com",
                hintStyle: TextStyle(color: const Color.fromARGB(255, 175, 173, 173), fontWeight: FontWeight.bold)
             ),
           ),
                  ),
                ),
               ),
         ),
       ],
     ),
      SizedBox(height: 5,),

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
                         hintStyle: TextStyle(color: const Color.fromARGB(255, 188, 187, 187), fontWeight: FontWeight.bold)
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
     SizedBox(
      height: 5,
     ),
      SizedBox(height: 5,),
       Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('Branch', style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontSize: 20, fontWeight: FontWeight.bold),),
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
                child:    Expanded(
                  child: Padding(
           padding: const EdgeInsets.only(top: 4, left: 10),
           child: TextField(
             style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontWeight: FontWeight.bold),
             decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Software engineering",
                hintStyle: TextStyle(color: const Color.fromARGB(255, 177, 177, 177), fontWeight: FontWeight.bold)
             ),
           ),
                  ),
                ),
               ),
         ),
       ],
     ),
     SizedBox(
      height:10,
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
                        builder: (BuildContext context) => Dashboard_supervisor(),
                      ));
        },
        child: Center(child: Text('SignUp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),)),
        
      ),
    ),
  ),
),
  ],
),

    );
  }
}