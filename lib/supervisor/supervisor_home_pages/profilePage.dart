import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intern_system/login_pages/reset_password.dart';
class SupervisorProfile extends StatefulWidget {
  const SupervisorProfile({super.key});

  @override
  State<SupervisorProfile> createState() => _SupervisorProfileState();
}

class _SupervisorProfileState extends State<SupervisorProfile> {
  bool _ischecked = false;
    final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  void _openGallery() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    setState(() {
      _imageFile = image;
    });
  }
}
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
      "Bit Tracks Profile",
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
    Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: const Color.fromARGB(255, 114, 26, 20),
        ),
        SizedBox(
          height: 250,
        ),
      Padding(
  padding: const EdgeInsets.only(left: 110, top: 100),
  child: Container(
    height: 200,
    width: 200,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: _imageFile != null
            ? (kIsWeb
                ? NetworkImage(_imageFile!.path)
                : FileImage(File(_imageFile!.path)) as ImageProvider)
            : AssetImage('assets/laughing.jpg'),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.all(Radius.circular(100)),
      border: Border.all(width: 3, color: Colors.white),
    ),
  ),
),
        Padding(
          padding: const EdgeInsets.only(top: 260, left: 220),
          child:Container(
                    height: 70, 
                    width: 70,
                    decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 3, color: Colors.white)
                    ),
                    child: IconButton(onPressed: _openGallery, 
                    icon: Icon(Icons.camera_enhance, size: 50, color: const Color.fromARGB(255, 123, 123, 123),) ,)
                  ),
        ),
      ],
    ),
    Center(child: Text("Mr Nchi Marcnus", style: TextStyle(color: const Color.fromARGB(255, 107, 106, 106),fontSize:20, fontWeight: FontWeight.bold),)),
    Center(child: Text("Networking", style: TextStyle(color: const Color.fromARGB(255, 107, 106, 106),fontSize:22, fontWeight: FontWeight.bold),)),
    SizedBox(height: 40,),
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
          padding: const EdgeInsets.only(top: 16),
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: TextField(
              style: TextStyle(color: const Color.fromARGB(255, 100, 99, 99), fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'nchimarcnus@gmail.com',
                border: InputBorder.none,
                 hintStyle: TextStyle(color: const Color.fromARGB(255, 172, 172, 172), fontWeight: FontWeight.bold)
              ),
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
      child: TextButton(onPressed: (){},
        child: Center(child: Text('save', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),)),
        
      ),
    ),
  ),
),
 TextButton(onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ResetPassword(),
                      ));
        },
        child:  Align(
alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text('Change Password?', textAlign: TextAlign.right, style: TextStyle(color: const Color.fromARGB(255, 114, 26, 20),fontWeight: FontWeight.bold),),
          )),
        
      ),
       
  ],
),
    );
  }
}
