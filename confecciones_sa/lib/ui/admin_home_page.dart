import 'package:confeccionessaapp/app/settings/application.dart';
import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/home_bloc.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:confeccionessaapp/ui/report_page.dart';
import 'package:confeccionessaapp/ui/roles_page.dart';
import 'package:confeccionessaapp/ui/sign_in_page.dart';
import 'package:confeccionessaapp/ui/time_schedule_page.dart';
import 'package:confeccionessaapp/ui/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AdminHomePage extends StatefulWidget {

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends BaseState<AdminHomePage, HomeBloc> {
  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _setupNotifications();
  }

  @override
  HomeBloc getBlocInstance() {
    return HomeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(l10n.admin),
        backgroundColor: ApplicationColors().primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _logOut();
            },
          ),],
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            buildMenu(l10n.roles, _openRolesPage),
            buildMenu(l10n.assignRol, _openUsersPage),
            buildMenu(l10n.productionReport, _openReportPage),
            buildMenu(l10n.timeSchedule, _openTimeSchedulePage)
          ],
        ),
      ),
    );
  }

  Widget buildMenu(String title, Function function) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Row(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                height: 1.0,
                fontWeight: FontWeight.w300),
          ),
          IconButton(
            icon: Icon(Icons.arrow_right),
          )
        ],
      ),
    );
  }

  void _openUsersPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UsersPage(),
      ),
    );
  }

  void _openRolesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RolesPage(),
      ),
    );
  }

  void _openReportPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ReportPage(),
      ),
    );
  }

  void _openTimeSchedulePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TimeSchedulePage(),
      ),
    );
  }

  void _logOut() {
    Application().applicationUser = null;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
          (route) => false,
    );
  }

  void _setupNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future selectNotification(String payload) async {

  }

  Future onDidReceiveLocalNotification(int param1, String param2, String param3, String param4) async {

  }
}