import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class SchedulesData extends ChangeNotifier {
  String alarm1Title, alarm1Time;
  String alarm2Title, alarm2Time;
  String alarm3Title, alarm3Time;

  // RETRIEVE ALL DATA ALARMS
  void getDataAlarm1() async {
    await FirebaseDatabase.instance
        .reference()
        .child('schedules_data')
        .child('alarm_1')
        .once()
        .then((value) {
      print(value.value);
      Map retrieved = value.value;
      retrieved.forEach((key, value) {
        if (key == 'title') {
          alarm1Title = value;
        } else if (key == 'time') {
          alarm1Time = value;
        }
      });
    });

    notifyListeners();
  }

  void getDataAlarm2() async {
    await FirebaseDatabase.instance
        .reference()
        .child('schedules_data')
        .child('alarm_2')
        .once()
        .then((value) {
      print(value.value);
      Map retrieved = value.value;
      retrieved.forEach((key, value) {
        if (key == 'title') {
          alarm2Title = value;
        } else if (key == 'time') {
          alarm2Time = value;
        }
      });
    });

    notifyListeners();
  }

  void getDataAlarm3() async {
    await FirebaseDatabase.instance
        .reference()
        .child('schedules_data')
        .child('alarm_3')
        .once()
        .then((value) {
      print(value.value);
      Map retrieved = value.value;
      retrieved.forEach((key, value) {
        if (key == 'title') {
          alarm3Title = value;
        } else if (key == 'time') {
          alarm3Time = value;
        }
      });
    });

    notifyListeners();
  }

  // SET OR UPDATE DATA ALARMS
  void setDataAlarm1(String title, String time) async {
    await FirebaseDatabase.instance
        .reference()
        .child('schedules_data')
        .child('alarm_1')
        .update({
      'time': time,
      'title': title,
    });

    notifyListeners();
  }

  void setDataAlarm2(String title, String time) async {
    await FirebaseDatabase.instance
        .reference()
        .child('schedules_data')
        .child('alarm_2')
        .update({
      'time': time,
      'title': title,
    });

    notifyListeners();
  }

  void setDataAlarm3(String title, String time) async {
    await FirebaseDatabase.instance
        .reference()
        .child('schedules_data')
        .child('alarm_3')
        .update({
      'time': time,
      'title': title,
    });

    notifyListeners();
  }
}
