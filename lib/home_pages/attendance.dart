import 'package:flutter/material.dart';
import 'package:intern_system/supervisor/supervisor_home_pages/reusablewigets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  DateTime _focusedDay = DateTime.now();       // Current view on the calendar
  DateTime? _selectedDay;                      // Day selected by the user
  final TextEditingController _descriptionController = TextEditingController();
Future<void> _saveAttendanceDescription(DateTime date, String description) async {
  final internId = FirebaseAuth.instance.currentUser?.uid;
  if (internId == null) return;

  final formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  final docRef = FirebaseFirestore.instance
      .collection('interns')
      .doc(internId)
      .collection('description')
      .doc(formattedDate);

  final existingDoc = await docRef.get();

  if (existingDoc.exists) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Log book have already been filled for.", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  await docRef.set({
    'date': date,
    'description': description,
    'isPresent': true,
    'timestamp': FieldValue.serverTimestamp(),
  });

  setState(() {
    attendanceRecords[date] = AttendanceEntry(isPresent: true, description: description);
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Attendance saved successfully!", style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.green,
    ),
  );
}

void _openAttendanceModal(BuildContext context, DateTime selectedDay) {
  final TextEditingController _descriptionController = TextEditingController();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Mark Attendance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Enter description...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Submit"),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
              onPressed: () async {
                try {
                  await _saveAttendanceDescription(selectedDay, _descriptionController.text);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Attendance saved successfully!", style: TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to save attendance: $e", style: TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    },
  );
}


Map<String, double> attendanceData = {
  "Present": 80,
  "Absent": 20,
};
void _updatePieChartData() {
int presentCount = attendanceRecords.values.where((v) => v.isPresent).length;
int absentCount = attendanceRecords.values.where((v) => !v.isPresent).length;

  int total = presentCount + absentCount;

  setState(() {
    attendanceData = {
      "Present": total == 0 ? 0 : (presentCount / total) * 100,
      "Absent": total == 0 ? 0 : (absentCount / total) * 100,
    };
  });
}

Map<DateTime, AttendanceEntry> attendanceRecords = {};

void _saveAttendance(DateTime date, bool isPresent, String description) {
  DateTime key = DateTime(date.year, date.month, date.day);
  if (attendanceRecords.containsKey(key)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Attendance already marked for today.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.secondaryColor,
      ),
    );
    return;
  }

  setState(() {
    attendanceRecords[key] = AttendanceEntry(isPresent: isPresent, description: description);
    _updatePieChartData();
  });
}



  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
       appBar: AppBar(
  backgroundColor: AppColors.primaryColor,
  leading:
  IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white,),
    onPressed: () {
      Navigator.pop(context);
    },
  ),

  title: Align(
    child: Text(
      "Bit Tracks Attendance",
      style: TextStyle(
        fontSize: screenWidth * 0.05,
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
        height: screenHeight * 0.04,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          height: screenHeight * 0.4,
          width: screenWidth * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.secondaryColor,
                width: 2,
            )
          ),
          child: TableCalendar(
            calendarStyle: CalendarStyle(
  todayDecoration: BoxDecoration(
    color: Colors.deepPurpleAccent,
    shape: BoxShape.circle,
  ),
  selectedDecoration: BoxDecoration(
    color: const Color.fromRGBO(255, 186, 96, 1),
    shape: BoxShape.circle,
  ),
),

            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
             DateTime today = DateTime.now();
  DateTime currentDate = DateTime(today.year, today.month, today.day);
  DateTime selectedDate = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
  
  if (selectedDate == currentDate) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
    _openAttendanceModal(context, selectedDay);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("You can only mark attendance for today.", style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),),
        backgroundColor: AppColors.secondaryColor,
      ),
    );
  }

            },
          ),
        ),
      ),
      SizedBox(height: screenHeight * 0.03,),
      Text(
        "Attendance Overview",
        style: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ),
      SizedBox(height: screenHeight * 0.03),
      PieChart(
  dataMap: attendanceData,
  animationDuration: Duration(milliseconds: 800),
  chartRadius: MediaQuery.of(context).size.width / 2.2,
  colorList: [const Color.fromARGB(255, 120, 120, 190), const Color.fromARGB(255, 199, 26, 14)],
  chartType: ChartType.disc,
  legendOptions: LegendOptions(
    showLegends: true,
    legendPosition: LegendPosition.right,
    legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  chartValuesOptions: ChartValuesOptions(
    showChartValuesInPercentage: true,
    showChartValues: true,
    chartValueStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
),
SizedBox(height: screenHeight * 0.03,),
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
  ),
  onPressed: () {
    _showAttendanceHistory(context);
  },
  child: Text("View Attendance History", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
),


  ],
),

    );
  }
}
class AttendanceEntry {
  final bool isPresent;
  final String description;
  AttendanceEntry({required this.isPresent, required this.description});
}
Map<DateTime, AttendanceEntry> attendanceRecords = {};
void _showAttendanceHistory(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      List<MapEntry<DateTime, AttendanceEntry>> sortedEntries = attendanceRecords.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key)); // Sort by date descending

      return Container(
        padding: EdgeInsets.all(16),
        height: 400,
        child: Column(
          children: [
            Text("Attendance History", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: sortedEntries.length,
                itemBuilder: (context, index) {
                  final entry = sortedEntries[index];
                  final dateStr = "${entry.key.year}-${entry.key.month.toString().padLeft(2, '0')}-${entry.key.day.toString().padLeft(2, '0')}";
                  return ListTile(
                    leading: Icon(entry.value.isPresent ? Icons.check_circle : Icons.cancel,
                        color: entry.value.isPresent ? Colors.green : Colors.red),
                    title: Text(dateStr, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(entry.value.description.isEmpty ? "No description" : entry.value.description),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
