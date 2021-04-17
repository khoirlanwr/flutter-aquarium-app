import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_getx/providers/set_data_provider.dart';
import 'package:todo_getx/widgets/home_tab.dart';
import 'package:todo_getx/widgets/logout_tab.dart';
import 'package:todo_getx/widgets/navbar_bottom.dart';
import 'package:todo_getx/widgets/navbar_top.dart';
import 'package:todo_getx/widgets/schedule_tab.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  int _toPage;

  @override
  void initState() {
    super.initState();
    _toPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavbarTop(),
          Container(
            height: 600,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  if (value == 0)
                    _toPage = null;
                  else
                    _toPage = value;
                  print(_toPage);
                });
              },
              controller: _pageController,
              children: [HomeTab(), ScheduleTab(), LogoutTab()],
            ),
          ),
          NavbarBottom(
            toPage: _toPage,
            onSelectIcon: (value) {
              _pageController.jumpToPage(value);
            },
          )
        ],
      ),
    )));
  }
}
