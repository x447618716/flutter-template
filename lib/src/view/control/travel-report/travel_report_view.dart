import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/empty.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class TravelReportView extends StatefulWidget {
  const TravelReportView({super.key});

  @override
  State<StatefulWidget> createState() => _TravelReportView();
}

class _TravelReportView extends State<TravelReportView> {

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.tripReport,
      ),
      body:Column(
        children: [
          Padding(padding:  const EdgeInsets.all(20.0),child: Text("设备号：1232454654878",style: TextStyle(fontSize: 15.sp,color: const Color.fromRGBO(61, 61, 61, 1)))),
          Padding(padding: const EdgeInsets.all(20.0),child:  TableCalendar(
            locale: 'zh_CN',
            firstDay: DateTime.utc(2024, 1, 16),
            lastDay: DateTime.utc(2100, 3, 14),
            focusedDay: _focusedDay,
            currentDay: DateTime.now(),
            headerVisible: false,
            headerStyle: const HeaderStyle(titleCentered: true),
            daysOfWeekVisible: false,
            calendarFormat: CalendarFormat.week,
            availableCalendarFormats: const {
              CalendarFormat.week: 'Week'
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
          )),
          const Expanded(child: Empty())
        ],
      ),
    );
  }
}
