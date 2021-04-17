import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_getx/providers/schedules_data.dart';
import 'package:todo_getx/widgets/navbar_top.dart';

class UpdateSchedule extends StatefulWidget {
  final int id;
  final String title;
  final String time;

  UpdateSchedule({this.id, this.title, this.time});

  @override
  _UpdateScheduleState createState() => _UpdateScheduleState();
}

class _UpdateScheduleState extends State<UpdateSchedule> {
  String _hour, _minute, _time;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ":" + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2021, 02, 20, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  String preProcessingTime() {
    String _preHour = "";
    String _preMinute = "";

    if (selectedTime.hour < 10) _preHour = "0";
    if (selectedTime.minute < 10) _preMinute = "0";

    String returnTime = _preHour + _hour + ":" + _preMinute + _minute;
    return returnTime;
  }

  void updateData() {
    String settedTime = preProcessingTime();

    // kondisional berdasarkan id untuk memanggil fungsi update data
    if (widget.id == 1) {
      // panggil update data alarm 1
      Provider.of<SchedulesData>(context, listen: false)
          .setDataAlarm1(_titleController.text, settedTime);
    } else if (widget.id == 2) {
      // panggil update data alarm 2
      Provider.of<SchedulesData>(context, listen: false)
          .setDataAlarm2(_titleController.text, settedTime);
    } else if (widget.id == 3) {
      // panggil update data alarm 3
      Provider.of<SchedulesData>(context, listen: false)
          .setDataAlarm3(_titleController.text, settedTime);
    }
  }

  @override
  void initState() {
    if (widget.time != null) _timeController.text = widget.time;
    if (widget.title != null) _titleController.text = widget.title;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var titleField = Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 54.0,
      width: 280.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: _titleController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20.0),
        decoration: InputDecoration(
            hintText: 'Judul Reminder',
            prefixIcon: Icon(Icons.title),
            border: InputBorder.none),
      ),
    );

    var intro = Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Text('Input Reminder',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontSize: 18.0)),
    );

    var timeField = InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: 140,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          textAlign: TextAlign.center,
          onSaved: (String val) {},
          enabled: false,
          keyboardType: TextInputType.text,
          controller: _timeController,
          decoration: InputDecoration(
              disabledBorder:
                  UnderlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );

    var updateForm = Container(
      padding: EdgeInsets.only(top: 40, left: 30, right: 30),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          intro,
          titleField,
          timeField,
        ],
      ),
    );

    var addButton = Padding(
      padding: EdgeInsets.only(top: 370),
      child: GestureDetector(
        onTap: () {
          updateData();
          Navigator.pop(context);
        },
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.lightBlue[300],
                borderRadius: BorderRadius.circular(8)),
            child: Text('Simpan',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white))),
      ),
    );

    return SafeArea(
        child: Scaffold(
            body: Container(
                child: Column(
      children: [
        NavbarTop(),
        updateForm,
        addButton,
      ],
    ))));
  }
}
