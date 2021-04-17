import 'package:flutter/material.dart';

class AlarmCard extends StatelessWidget {
  final String time;
  final String title;
  final String icon;

  AlarmCard({this.time, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: Colors.lightBlue[50]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image(image: AssetImage('$icon')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$title',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20)),
                SizedBox(
                  height: 4,
                ),
                Text('$time',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 15))
              ],
            ),
          )
        ],
      ),
    );
  }
}
