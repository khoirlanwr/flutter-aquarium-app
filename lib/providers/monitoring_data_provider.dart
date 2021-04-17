import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class MonitoringDataProvider extends ChangeNotifier {
  int ntu;
  int pakan;
  int pH;
  int suhu;

  // RETRIEVE DATA FUNCTION
  void retrieveMonitoringData() async {
    await FirebaseDatabase.instance
        .reference()
        .child('monitoring_data')
        .once()
        .then((value) {
      Map retrieved = value.value;
      print(retrieved);

      retrieved.forEach((key, value) {
        if (key == 'ntu') {
          ntu = value;
        } else if (key == 'pakan') {
          pakan = value;
        } else if (key == 'ph') {
          pH = value;
        } else if (key == 'suhu') {
          suhu = value;
        }
      });
    });

    // print(suhu);
    notifyListeners();
  }

  int getDataNTU() {
    return ntu;
  }

  int getDataPakan() {
    return pakan;
  }

  int getDataPH() {
    return pH;
  }
}

MonitoringDataProvider monitoringDataProvider = new MonitoringDataProvider();
