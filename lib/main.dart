import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_getx/providers/monitoring_data_provider.dart';
import 'package:todo_getx/providers/schedules_data.dart';
import 'package:todo_getx/providers/set_data_provider.dart';
import 'package:todo_getx/screens/home_page.dart';
import 'package:todo_getx/screens/landing_page.dart';
import 'package:todo_getx/screens/login_page.dart';
import 'package:todo_getx/screens/register_page.dart';
import 'package:todo_getx/screens/update_schedule.dart';

import 'package:todo_getx/services/app_retain_widget.dart';
import 'package:flutter/services.dart';
import 'package:todo_getx/services/backgroundMain.dart';

import 'package:todo_getx/services/counter_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().whenComplete(() {
    print("------------------------> firebase initial completed");
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SetDataProvider()),
      ChangeNotifierProvider(create: (context) => MonitoringDataProvider()),
      ChangeNotifierProvider(create: (context) => SchedulesData())
    ],
    child: MyApp(),
  ));

  // initial background service
  var channel = const MethodChannel('com.example/background_service');
  var callbackHandle = PluginUtilities.getCallbackHandle(backgroundMain);
  channel.invokeMethod('startService', callbackHandle.toRawHandle());
}

class MyApp extends StatefulWidget {
  static const String _title = 'Provider Sign-In Example';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("firebase initial completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppRetainWidget(
      child: MaterialApp(
        theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
        title: MyApp._title,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LandingPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomePage(),
          '/updateSchedule': (context) => UpdateSchedule()
        },
      ),
    );
  }
}
