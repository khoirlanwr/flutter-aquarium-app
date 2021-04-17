import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavbarBottom extends StatefulWidget {
  final Function(int) onSelectIcon;
  final int toPage;

  NavbarBottom({this.onSelectIcon, this.toPage});

  @override
  _NavbarBottomState createState() => _NavbarBottomState();
}

class _NavbarBottomState extends State<NavbarBottom> {
  bool _home = true;
  bool _schedule = false;
  bool _exit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.toPage);

    if (widget.toPage == null) {
      _home = true;
      _schedule = _exit = false;

      widget.onSelectIcon(0);
    }

    if (widget.toPage == 1) {
      _schedule = true;
      _home = _exit = false;

      widget.onSelectIcon(1);
    }

    if (widget.toPage == 2) {
      _exit = true;
      _home = _schedule = false;

      widget.onSelectIcon(2);
    }

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: double.infinity,
      padding: EdgeInsets.only(top: 10, left: 50, right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  _home = true;
                  _schedule = _exit = false;

                  widget.onSelectIcon(0);
                });
              },
              child: BottomIcon(selected: _home, selectedIcon: Icons.home)),
          GestureDetector(
              onTap: () {
                setState(() {
                  _schedule = true;
                  _home = _exit = false;

                  widget.onSelectIcon(1);
                });
              },
              child: BottomIcon(
                  selected: _schedule, selectedIcon: Icons.schedule)),
          GestureDetector(
              onTap: () {
                setState(() {
                  FirebaseAuth.instance.signOut();
                });
              },
              child: BottomIcon(selected: _exit, selectedIcon: Icons.logout))
        ],
      ),
    );
  }
}

class BottomIcon extends StatelessWidget {
  final IconData selectedIcon;
  final bool selected;

  BottomIcon({this.selectedIcon, this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            width: 2.0,
            color: selected == true ? Colors.lightBlue : Colors.white,
          ))),
      child: Icon(
        selectedIcon,
        size: 26,
        color: selected == true ? Colors.lightBlue[800] : Colors.black87,
      ),
    );
  }
}
