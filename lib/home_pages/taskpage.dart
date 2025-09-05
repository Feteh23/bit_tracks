import 'package:flutter/material.dart';

class Taskpage extends StatelessWidget {
  const Taskpage({super.key});

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
      "Bit Tracks task",
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
body: SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: Column(
    children: [
      SizedBox(
        height: 35,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.notification_important, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
                SizedBox(width: 15,),
                Text('create an e_commerce app', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
              ],
            ),
              SizedBox(
          height: 15,
        ),
         Row(
          children: [
            Icon(Icons.start_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Text('start:Aug 17, 2025' , style: TextStyle( fontSize: 19),)
          ],
        ),
           SizedBox(
          height: 15,
        ),
         Row(
          children: [
            Icon(Icons.stop_circle_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Text('Due: Aug 23, 2025', style: TextStyle( fontSize: 19),)
          ],
        ),
         SizedBox(
          height: 15,
        ),
         Row(
          children: [
            Icon(Icons.description_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Expanded(
              child: Text('Design an ecommerce website, where a user can buy iterms online.', style: TextStyle( fontSize: 19),
              softWrap: true,
              overflow: TextOverflow.visible,
              ),
            )
          ],
        ),
          ],
        ),
      ),
       SizedBox(
        height: 30,
      ),
      Container(
            height: 70,
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
           padding: const EdgeInsets.only(top: 5, left: 15),
           child: TextField(
             style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontWeight: FontWeight.bold),
             decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter a link or text here...",
                hintStyle: TextStyle(color: const Color.fromARGB(255, 175, 173, 173), fontWeight: FontWeight.bold)
             ),
           ),
         ),
       ),
               ),
               SizedBox(height: 30),
  
  SizedBox(height: 35),
  
  ElevatedButton.icon(
  onPressed: () {
  
  },
  icon: Icon(Icons.check),
  label: Text('Submit Task'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 114, 26, 20),
    foregroundColor: Colors.white,
  ),
  ),
  SizedBox(
        height: 30,
      ),
  Divider(
    thickness: 2,
    color: Color.fromARGB(255, 114, 26, 20),
    indent: 15,
    endIndent: 15,
  ),
    SizedBox(
        height: 30,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.notification_important, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
                SizedBox(width: 15,),
                Text('Design a potfolio', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
              ],
            ),
            
         SizedBox(
          height: 15,
        ),
         Row(
          children: [
            Icon(Icons.start_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Text('start:Aug 17, 2025' , style: TextStyle( fontSize: 19),)
          ],
        ),
           SizedBox(
          height: 15,
        ),
         Row(
          children: [
            Icon(Icons.stop_circle_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Text('Due: Aug 23, 2025', style: TextStyle( fontSize: 19),)
          ],
        ),
         SizedBox(
          height: 15,
        ),
         Row(
          children: [
            Icon(Icons.description_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Expanded(
              child: Text('Design a potfolio, where a user can upload their images as profile.', style: TextStyle( fontSize: 19),
              softWrap: true,
              overflow: TextOverflow.visible,
              ),
            )
          ],
        ),
          ],
        ),
      ),
       SizedBox(
        height: 30,
      ),
      Container(
            height: 70,
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
           padding: const EdgeInsets.only(top: 5, left: 15),
           child: TextField(
             style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontWeight: FontWeight.bold),
             decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter a link or text here...",
                hintStyle: TextStyle(color: const Color.fromARGB(255, 175, 173, 173), fontWeight: FontWeight.bold)
             ),
           ),
         ),
       ),
               ),
               SizedBox(height: 30),
  
  SizedBox(height: 35),
  
  ElevatedButton.icon(
  onPressed: () {
  
  },
  icon: Icon(Icons.check),
  label: Text('Submit Task'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 114, 26, 20),
    foregroundColor: Colors.white,
  ),
  ),
  
                           
    ],
  ),
),
    );
  }
}