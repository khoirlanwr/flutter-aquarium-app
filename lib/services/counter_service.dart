import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_getx/providers/monitoring_data_provider.dart';
import 'package:todo_getx/providers/set_data_provider.dart';

import 'package:todo_getx/services/counter.dart';

class CounterService {
  factory CounterService.instance() => _instance;

  CounterService._internal();

  static final _instance = CounterService._internal();

  final _counter = Counter();

  ValueListenable<int> get count => _counter.count;

  void startCounting() {
    Stream.periodic(Duration(seconds: 5)).listen((_) async {
      // _counter.increment();
      // print('Counter Incremented: ${_counter.count.value}');

      print("Background job is running");

      // let your function here
      // firedNotification();
      // conditionRequiredReminder();
      statusConditionNotifications();
    });
  }

  String preProcessGetTime(TimeOfDay time) {
    String _preHourTime = "";
    String _preMinuteTime = "";

    if (time.hour < 10) _preHourTime = "0";
    if (time.minute < 10) _preMinuteTime = "0";

    return _preHourTime +
        time.hour.toString() +
        ":" +
        _preMinuteTime +
        time.minute.toString();
  }

  String timeNow() {
    TimeOfDay _timeNow = TimeOfDay.now();
    return preProcessGetTime(_timeNow);
  }

  void firstCondition(int statusPakan) {
    if (statusPakan == 0) {
      print('Pakan habis!');
    }
  }

  void secondCondition(int dataNTU, int settedNTU) {
    if (dataNTU >= settedNTU) {
      print('Air sudah keruh!');
    }
  }

  void lastCondition(int dataPH, int settedPH) {
    if (dataPH > settedPH) print('dataPH melebihi yang sudah ditentukan');
    if (dataPH < settedPH) print('dataPH kurang dari yang sudah ditentukan');
  }

  void statusConditionNotifications() async {
    // initial firebase
    Firebase.initializeApp().whenComplete(() {
      print("------------------------> firebase initial completed");
    });

    // access all data firstly
    monitoringDataProvider.retrieveMonitoringData();
    setDataProvider.readDataSet();

    // kondisi 0: tidak ada status
    // kondisi 1: notifikasi saat pakan habis
    int statusPakan = monitoringDataProvider.getDataPakan();
    firstCondition(statusPakan);

    // kondisi 2: notifikasi saat NTU lebih besar dari set NTU (air sudah keruh)
    int dataNTU = monitoringDataProvider.getDataNTU();
    int settedNTU = setDataProvider.getSettedNTU();
    secondCondition(dataNTU, settedNTU);

    // kondisi 3: notifikasi saat pH < set pH
    // kondisi 4: notifikasi saat pH > set pH
    int dataPH = monitoringDataProvider.getDataPH();
    int settedPH = setDataProvider.getSettedPH();
    lastCondition(dataPH, settedPH);
  }

  void conditionRequiredReminder() async {
    // initial firebase
    Firebase.initializeApp().whenComplete(() {
      print("------------------------> firebase initial completed");
    });
  }
}
