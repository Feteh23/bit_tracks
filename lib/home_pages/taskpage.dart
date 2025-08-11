import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

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
        padding: const EdgeInsets.only(left: 25),
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
            Icon(Icons.calendar_month_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Text('Due: Aug 25, 2025', style: TextStyle( fontSize: 19),)
          ],
        ),
         SizedBox(
          height: 15,
        ),
         Row(
          children: [
            Icon(Icons.picture_as_pdf_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Text('e_commerce.pdf', style: TextStyle( fontSize: 19),)
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
  
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Column(
      children: [
        IconButton(
          icon: Icon(Icons.camera_alt, size: 30),
          onPressed: () async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected Image: ${image.name}')),
    );
    // You can also preview or upload the image here
  }
},

        ),
        SizedBox(
          width: 20,
        ),
        Text('Upload Image'),
      ],
    ),
    SizedBox(height: 20,),
    Column(
      children: [
        IconButton(
          icon: Icon(Icons.picture_as_pdf, size: 30),
         onPressed: () async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null && result.files.single.path != null) {
    final fileName = result.files.single.name;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected PDF: $fileName')),
    );
    // You can preview or upload the PDF here
  }
},

        ),
        SizedBox(height: 20),
        Text('Upload PDF'),
      ],
    ),
  ],
  ),
  
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
        height: 45,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25),
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
            Icon(Icons.calendar_month_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Text('Due: Aug 15, 2025', style: TextStyle( fontSize: 19),)
          ],
        ),
         SizedBox(
          height: 15,
        ),
         Row(
          children: [
            Icon(Icons.picture_in_picture_outlined, size: 25, color: const Color.fromARGB(255, 114, 26, 20),),
            SizedBox(width: 15,),
            Text('potfolio.jpg', style: TextStyle( fontSize: 19),)
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
  
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Column(
      children: [
        IconButton(
          icon: Icon(Icons.camera_alt, size: 30),
          onPressed: () {
            
          },
        ),
        SizedBox(
          width: 20,
        ),
        Text('Upload Image'),
      ],
    ),
    SizedBox(height: 20,),
    Column(
      children: [
        IconButton(
          icon: Icon(Icons.picture_as_pdf, size: 30),
          onPressed: () {
            
          },
        ),
        SizedBox(height: 20),
        Text('Upload PDF'),
      ],
    ),
  ],
  ),
  
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