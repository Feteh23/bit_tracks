import 'package:flutter/material.dart';
import 'package:intern_system/home_pages/dashborad.dart';
import 'package:intern_system/login_pages/signup.dart';
import 'package:intern_system/login_pages/reset_password.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}
bool _ischecked = true;
 bool _isobscured = false;
class _HomepageState extends State<Homepage> {
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
      "Bit Tracks Login",
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
    'assets/standing_girl.jpg',
     fit: BoxFit.cover,
          ),
           SizedBox(height: 25,),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text('Name', style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontSize: 20, fontWeight: FontWeight.bold),),
          )),

     Row(
       children: [
        SizedBox(
          width: 25,
        ),
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
     child:    Expanded(
       child: Padding(
         padding: const EdgeInsets.only(top: 4, left: 10),
         child: TextField(
           style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontWeight: FontWeight.bold),
           decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Feteh Mireille",
              hintStyle: TextStyle(color: const Color.fromARGB(255, 167, 167, 167), fontWeight: FontWeight.bold)
           ),
         ),
       ),
     ),
             ),
       ],
     ),
      SizedBox(height: 8,),
       Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text('Email', style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontSize: 20, fontWeight: FontWeight.bold),),
          )),

     Row(
       children: [
        SizedBox(
          width: 25,
        ),
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
       ],
     ),
       SizedBox(height: 8,),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text('Password', style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontSize: 20, fontWeight: FontWeight.bold),),
          )),

     Row(
       children: [
        SizedBox(
          width: 25,
        ),
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
       ],
     ),
      TextButton(onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>ResetPassword(),
                      ));
        },
        child:  Align(
alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text('Forget Password?', textAlign: TextAlign.right, style: TextStyle(color: const Color.fromARGB(255, 114, 26, 20),fontWeight: FontWeight.bold),),
          )),
        
      ),
       
        SizedBox(height: 3,),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              IconButton(onPressed: (){
                setState(() {
                 _isobscured = !_isobscured;
                });
               
             }, icon:Icon(_isobscured? Icons.check_box : Icons.check_box_outline_blank, color: _isobscured? const Color.fromARGB(255, 100, 99, 99): const Color.fromARGB(255, 100, 99, 99),)),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text('I accept all terms and conditions', style: TextStyle(fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
     SizedBox(
      height:20,
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
                        builder: (BuildContext context) => Dashborad(),
                      ));
        },
        child: Center(child: Text('Login', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),)),
        
      ),
    ),
  ),
),
  Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Text("Don't have an account"),
              ),
              TextButton(onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Signup(),
                      ));
        },
        child: Text('Sign Up', style: TextStyle(color: Color.fromARGB(255, 114, 26, 20),fontWeight: FontWeight.bold),),
        
      ),
              
            ],
          ),
 

  ],
),

    );
  }
}