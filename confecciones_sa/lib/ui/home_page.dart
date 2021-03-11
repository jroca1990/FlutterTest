import 'package:camera/camera.dart';
import 'package:confeccionessaapp/app/settings/application.dart';
import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/home_bloc.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:confeccionessaapp/ui/custom_widgets/alert_dialog.dart';
import 'package:confeccionessaapp/ui/production_records_page.dart';
import 'package:confeccionessaapp/ui/record_production_page.dart';
import 'package:confeccionessaapp/ui/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
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
        title: new Text(l10n.employee),
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
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          buildUserInfo(),
          buildRegisterProductionMenu(),
          buildRecordsProductionMenu(),
        ],
      ),
    );
  }

  Widget buildUserInfo() {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Application().applicationUser.email,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  height: 1.0,
                  fontWeight: FontWeight.w300),
            ),
            Application().applicationUser.rol != null? Text(
              Application().applicationUser.rol.name ,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                  height: 1.0,
                  fontWeight: FontWeight.w300),
            ) : Container(height: 0.0,)
          ],
        )
    );
  }

  Widget buildRegisterProductionMenu() {
    return GestureDetector(
        onTap: () {
          _recordProduction();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
          child:Row(
            children: <Widget>[
              Text(
                l10n.recordProduction,
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
        )
    );
  }

  Widget buildRecordsProductionMenu() {
    return GestureDetector(
        onTap: () {
          _productionRecords();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child:Row(
            children: <Widget>[
              Text(
                l10n.productionRecords,
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
        )
    );
  }

  void _recordProduction() async {
    if(Application().applicationUser.rol == null) {
      MessageAlertDialog().showMessage(context, l10n.message, l10n.noRolAssigned);
      return;
    }
    WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RecordProductionPage(camera: firstCamera,),
      ),
    );
  }

  void _productionRecords() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductionRecordsPage(),
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

    var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('repeating channel id',
        'repeating channel name', 'repeating description');
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(1, l10n.alert,
        l10n.rememberRecordProduction, RepeatInterval.EveryMinute, platformChannelSpecifics);
  }

  Future selectNotification(String payload) async {

  }

  Future onDidReceiveLocalNotification(int param1, String param2, String param3, String param4) async {

  }
}