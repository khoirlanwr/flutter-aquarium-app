import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_getx/providers/schedules_data.dart';
import 'package:todo_getx/screens/update_schedule.dart';
import 'package:todo_getx/widgets/alarm_card.dart';

class ScheduleTab extends StatefulWidget {
  @override
  _ScheduleTabState createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  var onDataSubscription;

  void accessData() {
    Provider.of<SchedulesData>(context, listen: false).getDataAlarm1();
    Provider.of<SchedulesData>(context, listen: false).getDataAlarm2();
    Provider.of<SchedulesData>(context, listen: false).getDataAlarm3();
  }

  @override
  void initState() {
    super.initState();

    // access data on initial
    accessData();

    // subscript on data changes
    onDataSubscription = FirebaseDatabase.instance
        .reference()
        .child('schedules_data')
        .onChildChanged
        .listen((event) {
      accessData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('Pengaturan Jadwal',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold)),
            ),
            Consumer<SchedulesData>(builder: (context, schedule, child) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateSchedule(
                                id: 1,
                                title: '${schedule.alarm1Title}',
                                time: '${schedule.alarm1Time}',
                              )));
                  // Navigator.pushNamed(context, '/updateSchedule');
                },
                child: AlarmCard(
                  icon: 'assets/images/emojione_alarm-clock.png',
                  time: '${schedule.alarm1Time}',
                  title: '${schedule.alarm1Title}',
                ),
              );
            }),
            Consumer<SchedulesData>(builder: (context, schedule, child) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateSchedule(
                                id: 2,
                                time: '${schedule.alarm2Time}',
                                title: '${schedule.alarm2Title}',
                              )));
                },
                child: AlarmCard(
                  icon: 'assets/images/emojione_alarm-clock.png',
                  time: '${schedule.alarm2Time}',
                  title: '${schedule.alarm2Title}',
                ),
              );
            }),
            Consumer<SchedulesData>(builder: (context, schedule, child) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateSchedule(
                                id: 3,
                                title: '${schedule.alarm3Title}',
                                time: '${schedule.alarm3Time}',
                              )));
                },
                child: AlarmCard(
                  icon: 'assets/images/emojione_alarm-clock.png',
                  time: '${schedule.alarm3Time}',
                  title: '${schedule.alarm3Title}',
                ),
              );
            }),
          ],
        ));
  }
}
