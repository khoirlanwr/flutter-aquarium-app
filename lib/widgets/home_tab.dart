import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_getx/providers/monitoring_data_provider.dart';
import 'package:todo_getx/providers/set_data_provider.dart';
import 'package:todo_getx/widgets/monitoring_card.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var subscriptionSetDataUpdate;
  var subscriptionMonitoringDataAdded;
  var subscriptionMonitoringDataUpdated;

  TextEditingController _ntuSetController = TextEditingController();
  TextEditingController _phSetController = TextEditingController();
  TextEditingController _takaranSetController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // access the data
    Provider.of<SetDataProvider>(context, listen: false).readDataSet();
    Provider.of<MonitoringDataProvider>(context, listen: false)
        .retrieveMonitoringData();

    // subscribe to event listener firebase
    subscriptionSetDataUpdate = FirebaseDatabase.instance
        .reference()
        .child('set_data')
        .onChildChanged
        .listen((event) {
      Provider.of<SetDataProvider>(context, listen: false).readDataSet();
    });

    subscriptionMonitoringDataUpdated = FirebaseDatabase.instance
        .reference()
        .child('monitoring_data')
        .onChildChanged
        .listen((event) {
      Provider.of<MonitoringDataProvider>(context, listen: false)
          .retrieveMonitoringData();
    });
  }

  // @override
  // void dispose() {
  //   subscriptionSetDataUpdate.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    var dataSetCard = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pengaturan',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold)),
          Container(
            margin: EdgeInsets.only(top: 6),
            padding: EdgeInsets.all(20),
            height: 80.0,
            decoration: BoxDecoration(
                color: Colors.lightBlue[900],
                borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Alert(
                        context: context,
                        title: 'Set NTU',
                        content: Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _ntuSetController,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                              decoration: InputDecoration(
                                  hintText: 'Input data ntu',
                                  border: InputBorder.none),
                            )
                          ],
                        ),
                        buttons: [
                          DialogButton(
                              child: Text('Set',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              onPressed: () async {
                                if (_ntuSetController.value != null) {
                                  int varNTU =
                                      int.parse(_ntuSetController.text);
                                  Provider.of<SetDataProvider>(context,
                                          listen: false)
                                      .setDataNTU(varNTU);
                                  print('set ntu');

                                  Navigator.pop(context);
                                }
                              })
                        ]).show();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Set NTU',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white54,
                              fontSize: 14)),
                      Consumer<SetDataProvider>(
                        builder: (context, setData, child) {
                          return Text('${setData.ntu}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18));
                        },
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // show alert dialog
                    Alert(
                        context: context,
                        title: 'Set PH',
                        content: Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _phSetController,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                              decoration: InputDecoration(
                                  hintText: 'Input data PH',
                                  border: InputBorder.none),
                            )
                          ],
                        ),
                        buttons: [
                          DialogButton(
                              child: Text('Set',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              onPressed: () async {
                                if (_phSetController.value != null) {
                                  int varPH = int.parse(_phSetController.text);
                                  Provider.of<SetDataProvider>(context,
                                          listen: false)
                                      .setDataPH(varPH);
                                  print('set ph');

                                  Navigator.pop(context);
                                }
                              })
                        ]).show();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Set pH',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white54,
                              fontSize: 14)),
                      Consumer<SetDataProvider>(
                          builder: (context, setDataPH, child) {
                        return Text('${setDataPH.pH}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18));
                      })
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Alert(
                        context: context,
                        title: 'Set Takaran',
                        content: Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _takaranSetController,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                              decoration: InputDecoration(
                                  hintText: 'Input takaran',
                                  border: InputBorder.none),
                            )
                          ],
                        ),
                        buttons: [
                          DialogButton(
                              child: Text('Set',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              onPressed: () async {
                                if (_takaranSetController.value != null) {
                                  int varTakaran =
                                      int.parse(_takaranSetController.text);
                                  Provider.of<SetDataProvider>(context,
                                          listen: false)
                                      .setTakaran(varTakaran);
                                  print('set takaran');

                                  Navigator.pop(context);
                                }
                              })
                        ]).show();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Takaran',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white54,
                              fontSize: 14)),
                      Consumer<SetDataProvider>(
                          builder: (context, setDataTakaran, child) {
                        return Text('${setDataTakaran.takaran}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18));
                      })
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

    var dataSetMonitoring1 = Container(
        child: Row(
      children: [
        Consumer<MonitoringDataProvider>(builder: (context, ph, child) {
          return Expanded(
            child: MonitoringCard(
              title: 'pH',
              imageURL: 'assets/images/mdi_test-tube.png',
              value: '${ph.pH}',
            ),
          );
        }),
        Consumer<MonitoringDataProvider>(builder: (context, suhu, child) {
          return Expanded(
            child: MonitoringCard(
              title: 'Suhu',
              imageURL: 'assets/images/uil_temperature.png',
              value: '${suhu.suhu}',
            ),
          );
        })
      ],
    ));

    var dataSetMonitoring2 = Container(
        child: Row(
      children: [
        Consumer<MonitoringDataProvider>(builder: (context, ntu, child) {
          return Expanded(
            child: MonitoringCard(
              title: 'NTU',
              imageURL: 'assets/images/ion_water.png',
              value: '${ntu.ntu}',
            ),
          );
        }),
        Consumer<MonitoringDataProvider>(builder: (context, pakan, child) {
          return Expanded(
            child: MonitoringCard(
              title: 'Pakan',
              imageURL: 'assets/images/icon-pakan.png',
              value: pakan.pakan == 1 ? 'Ada' : 'Habis',
            ),
          );
        })
      ],
    ));

    var cardsMonitoring = Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text('Monitoring Kondisi',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold)),
          ),
          dataSetMonitoring1,
          dataSetMonitoring2,
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [dataSetCard, cardsMonitoring],
      ),
    );
  }
}
