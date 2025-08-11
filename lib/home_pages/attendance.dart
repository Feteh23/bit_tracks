import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pie_chart/pie_chart.dart';


class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  DateTime _focusedDay = DateTime.now();       // Current view on the calendar
  DateTime? _selectedDay;                      // Day selected by the user

void _openAttendanceModal(BuildContext context, DateTime date) {
  String description = '';
  bool isPresent = true;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Attendance for ${date.toLocal().toString().split(' ')[0]}'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: Text(isPresent ? 'Present' : 'Absent'),
                  value: isPresent,
                  onChanged: (val) {
                    setModalState(() {
                      isPresent = val;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onChanged: (val) {
                    description = val;
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            child: Text('Save'),
           onPressed: () {
  _saveAttendance(date, isPresent, description);
  Navigator.of(context).pop();
},

          ),
        ],
      );
    },
  );
}

Map<String, double> attendanceData = {
  "Present": 80,
  "Absent": 20,
};
void _updatePieChartData() {
  int presentCount = attendanceRecords.values.where((v) => v).length;
  int absentCount = attendanceRecords.values.where((v) => !v).length;
  int total = presentCount + absentCount;

  setState(() {
    attendanceData = {
      "Present": total == 0 ? 0 : (presentCount / total) * 100,
      "Absent": total == 0 ? 0 : (absentCount / total) * 100,
    };
  });
}

Map<DateTime, bool> attendanceRecords = {};
void _saveAttendance(DateTime date, bool isPresent, String description) {
  setState(() {
    attendanceRecords[DateTime(date.year, date.month, date.day)] = isPresent;
    _updatePieChartData();
  });
  print('Saved: $date, Present: $isPresent, Note: $description');
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
      "Bit Tracks Attendance",
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
        height: 25,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          height: 40,
          width: 350,
          decoration: BoxDecoration(
            border: Border.all(
        color: const Color.fromARGB(255, 100, 99, 99),
        width: 1,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
        children: [
          Icon(Icons.search, color: const Color.fromARGB(255, 100, 99, 99)),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: TextStyle(
                color: const Color.fromARGB(255, 100, 99, 99),
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "search here.....",
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 175, 173, 173),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
            ),
          ),
        ),
      ),
      SizedBox(height: 35,),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          height: 400,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(255, 100, 99, 99),
                width: 2,
            )
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
              });
              _openAttendanceModal(context, selectedDay);
            },
          ),
        ),
      ),
SizedBox(height: 30),
Text(
  "Attendance Overview",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 114, 26, 20),
  ),
),
SizedBox(height: 30),
PieChart(
  dataMap: attendanceData,
  animationDuration: Duration(milliseconds: 800),
  chartRadius: MediaQuery.of(context).size.width / 2.2,
  colorList: [const Color.fromARGB(255, 100, 99, 99), const Color.fromARGB(255, 114, 26, 20)],
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

  ],
),

    );
  }
}