import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class SetDataProvider extends ChangeNotifier {
  // The current data to be consumed
  int ntu;
  int pH;
  int takaran;

  // READ DATA NTU
  void readDataSet() async {
    await FirebaseDatabase.instance
        .reference()
        .child('set_data')
        .once()
        .then((value) {
      print(value.value);
      Map retrievedData = value.value;
      retrievedData.forEach((key, value) {
        if (key == 'takaran') {
          takaran = value;
        } else if (key == 'ph') {
          pH = value;
        } else if (key == 'ntu') {
          ntu = value;
        }
      });
    });

    notifyListeners();
  }

  // SET DATA NTU
  void setDataNTU(int ntu) async {
    await FirebaseDatabase.instance
        .reference()
        .child('set_data')
        .update({'ntu': ntu});

    notifyListeners();
  }

  // SET DATA PH
  void setDataPH(int ph) async {
    await FirebaseDatabase.instance
        .reference()
        .child('set_data')
        .update({'ph': ph});

    notifyListeners();
  }

  // SET DATA PH
  void setTakaran(int takaran) async {
    await FirebaseDatabase.instance
        .reference()
        .child('set_data')
        .update({'takaran': takaran});

    notifyListeners();
  }

  int getSettedNTU() {
    return ntu;
  }

  int getSettedPH() {
    return pH;
  }
}

SetDataProvider setDataProvider = new SetDataProvider();
