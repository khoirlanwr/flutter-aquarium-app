import 'package:flutter/material.dart';

class NavbarTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var backButton = Container(
      child: Icon(
        Icons.chevron_left,
        size: 30,
      ),
    );

    var appTitle = Container(
      alignment: Alignment.center,
      child: Text('Aquarium Monitoring App',
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 20)),
    );

    var personIcon = Container(
      child: Icon(
        Icons.account_circle,
        color: Colors.lightBlue[800],
        size: 30,
      ),
    );

    return Container(
      height: 70,
      padding: EdgeInsets.only(
        top: 8,
        left: 15,
        right: 15,
        bottom: 8,
      ),
      decoration: BoxDecoration(color: Colors.blue[50]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [backButton, appTitle, personIcon],
      ),
    );
  }
}
