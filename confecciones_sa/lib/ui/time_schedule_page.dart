import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/users_bloc.dart';
import 'package:confeccionessaapp/di/injector.dart';
import 'package:confeccionessaapp/models/time_schedule.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class TimeSchedulePage extends StatefulWidget {

  @override
  _TimeSchedulePageState createState() => _TimeSchedulePageState();
}

class _TimeSchedulePageState extends BaseState<TimeSchedulePage, UsersBloc> {
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  String startTimeStr = '';
  String endTimeStr = '';

  TimeSchedule currentTimeSchedule;
  bool toSave = true;

  @override
  void initState() {
    super.initState();
    loadCurrentTimeSchedule();
  }

  void loadCurrentTimeSchedule() async {
    currentTimeSchedule = await bloc.getDefaultSchedule();
    if(currentTimeSchedule != null) {
      setState(() {
        toSave = false;
        startTimeStr =DateFormat('kk:mm').format(currentTimeSchedule.startTime);
        endTimeStr =DateFormat('kk:mm').format(currentTimeSchedule.endTime);
      });
    }
  }

  @override
  UsersBloc getBlocInstance() {
    return UsersBloc(Injector().provideUserUseCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(l10n.timeSchedule),
        backgroundColor: ApplicationColors().primaryColor,
        actions: <Widget>[
          //buildDeleteAction(),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              toSave ? _saveTimeSchedule() : _editTimeSchedule();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          child:  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(l10n.startTimeSchedule),
                      Padding(padding: EdgeInsets.fromLTRB(00.0, 5.0, 00.0, 0.0),),
                      Text("$startTimeStr"),
                      SizedBox(height: 20.0, width: 20),
                      RaisedButton(
                        color: ApplicationColors().secondaryColor,
                        onPressed: () => _selectTime(true),
                        child: Text(l10n.select,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                height: 1.0,
                                fontWeight: FontWeight.w300)),
                      ),
                    ],)
              ),

              Expanded(
                  child:Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(l10n.endTimeSchedule),
                      Padding(padding: EdgeInsets.fromLTRB(00.0, 5.0, 00.0, 0.0),),
                      Text("$endTimeStr"),
                      SizedBox(height: 20.0, width: 20),
                      RaisedButton(
                        color: ApplicationColors().secondaryColor,
                        onPressed: () => _selectTime(false),
                        child: Text(l10n.select,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                height: 1.0,
                                fontWeight: FontWeight.w300)),
                      ),
                    ],)
              )
            ],
          ),
        ),
      ),
    );
  }

  void _selectTime(bool isSartTime) {
    DatePicker.showTimePicker(context, showTitleActions: true, onChanged: (date) {
      setState(() {
        String formattedDate = date != null? DateFormat('kk:mm').format(date) : '';
        isSartTime == true?  startTimeStr = formattedDate : endTimeStr = formattedDate;
        isSartTime == true?  startTime = date : endTime = date;
        if(currentTimeSchedule == null) {
          currentTimeSchedule = TimeSchedule('', null, null);
        }
        if(isSartTime) {
          currentTimeSchedule.startTime = date;
        } else {
          currentTimeSchedule.endTime = date;
        }
      });
    }, onConfirm: (date) {
      print('confirm $date');
    }, currentTime: DateTime.now());
  }

  void _saveTimeSchedule() async {
    try {
      await bloc.addSchedule(startTime, endTime).then((result) {
        if (result != null) {
          Navigator.pop(context);
        }
      });
    } catch (e){
      print(e.toString());
    }
  }

  void _editTimeSchedule() async {
    await bloc.editSchedule(currentTimeSchedule).then((result) {
      if (result != null) {
        Navigator.pop(context);
      }
    });
  }
}