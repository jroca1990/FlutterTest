import 'dart:io';
import 'package:camera/camera.dart';
import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/users_bloc.dart';
import 'package:confeccionessaapp/di/injector.dart';
import 'package:confeccionessaapp/models/time_schedule.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:confeccionessaapp/ui/camera_page.dart';
import 'package:confeccionessaapp/ui/custom_widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class RecordProductionPage extends StatefulWidget {
  final CameraDescription camera;

  const RecordProductionPage({Key key, this.camera}) : super(key: key);

  @override
  _RecordProductionPageState createState() => _RecordProductionPageState();
}

class _RecordProductionPageState extends BaseState<RecordProductionPage, UsersBloc> {
  final TextEditingController _qtyController = TextEditingController();
  String imagePath ='';

  CameraController _controller;
  Future<void> _initializeControllerFuture;

  TimeSchedule currentTimeSchedule;

  @override
  void initState() {
    super.initState();
    loadCurrentTimeSchedule();


    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  void loadCurrentTimeSchedule() async {
    currentTimeSchedule = await bloc.getDefaultSchedule();
    if(currentTimeSchedule != null) {
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  UsersBloc getBlocInstance() {
    return UsersBloc(Injector().provideUserUseCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(l10n.recordProduction),
        backgroundColor: ApplicationColors().primaryColor,
        actions: <Widget>[
          //buildDeleteAction(),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveQty(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildQtyTitle(),
            buildQtyField(),
            SizedBox(height: 20),
            buildCamera(context),
            SizedBox(height: 20),
            buildImage(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return imagePath != null && imagePath != ''?
        Center(child: Container(height: 100, width:  100,
            child:
            Image.file(File(imagePath))),)
        : Container(height: 0,);

  }

  Widget buildQtyTitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 21.0, 0.0, 0.0),
      child: Text(l10n.qty,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              height: 1.0,
              fontWeight: FontWeight.w300)),
    );
  }

  Widget buildQtyField() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
      child: TextField(
        controller: _qtyController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        cursorColor: Color(0xFF1a1a1a),
        style: TextStyle(
          color: Color(0xFF1a1a1a),
          fontSize: 16,
        ),
      ),
    );
  }


  Widget buildCamera(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.camera_alt),
      // Provide an onPressed callback.
      onPressed: () async {
        WidgetsFlutterBinding.ensureInitialized();

        // Obtain a list of the available cameras on the device.
        final cameras = await availableCameras();

        // Get a specific camera from the list of available cameras.
        final firstCamera = cameras.first;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TakePictureScreen(camera: firstCamera),
          ),
        ).then((result) {
          setState(() {
            imagePath = result;
            //loadRoles();
          });
        });;
      },
    );
  }

  void _saveQty(BuildContext context) async {
    if(_qtyController.text.trim() == '') {
      MessageAlertDialog().showMessage(context, l10n.message, l10n.alertEmptyField);
      return;
    }

    if(currentTimeSchedule != null &&(DateTime.now().hour < currentTimeSchedule.startTime.hour || DateTime.now().hour > currentTimeSchedule.endTime.hour)) {
      MessageAlertDialog().showMessage(context, l10n.message, l10n.outTimeSchedule);
      return;
    }

    bloc.addRecordProduction(int.parse(_qtyController.text), imagePath).then((result) {
      if (result != null) {
        Navigator.pop(context);
      }
    });
  }
}