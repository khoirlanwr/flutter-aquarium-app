import 'package:flutter/material.dart';

class MonitoringCard extends StatelessWidget {
  final String title;
  final String imageURL;
  final String value;

  MonitoringCard({this.title, this.imageURL, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      height: 120,
      padding: EdgeInsets.only(left: 30, top: 15, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.blue[50], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black54)),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image(image: AssetImage('$imageURL'), width: 26),
              ),
              Text(value,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
