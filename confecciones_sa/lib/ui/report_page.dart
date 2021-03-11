import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/production_records_bloc.dart';
import 'package:confeccionessaapp/di/injector.dart';
import 'package:confeccionessaapp/models/record_production.dart';
import 'package:confeccionessaapp/models/user.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends BaseState<ReportPage, ProductionRecordsBloc> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year-10),
        lastDate: DateTime.now());
    if (picked != null && picked != DateTime.now())
      setState(() {
        selectedDate = picked;
        getAllProductionRecords();
      });
  }

  @override
  void initState() {
    super.initState();
    getAllProductionRecords();
  }

  @override
  ProductionRecordsBloc getBlocInstance() {
    return ProductionRecordsBloc(Injector().provideUserUseCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(l10n.productionReport),
        backgroundColor: ApplicationColors().primaryColor,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding (
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 0.0),
                child: Row(
                  children: <Widget>[
                    Text("${selectedDate.toLocal()}".split(' ')[0]),
                    SizedBox(height: 20.0, width: 20),
                    RaisedButton(
                      color: ApplicationColors().secondaryColor,
                      onPressed: () => _selectDate(context),
                      child: Text(l10n.selectDate,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              height: 1.0,
                              fontWeight: FontWeight.w300)),
                    ),
                  ],
                ),
              ),

              Expanded(
                child:  StreamBuilder<List<RecordProduction>>(
                  stream: bloc.productionRecords,
                  builder: (context, snapshot)
                  {
                    return snapshot.data == null?
                    Container(
                      height: 0.0,
                    ):
                    Padding (
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                          delegate: SliverChildListDelegate(snapshot.data
                              .map( (f) => buildItem(f)
                          ).toList()),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          ],
        )
      ),
    );
  }

  Widget buildItem(RecordProduction item) {

    return Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: GestureDetector(
          onTap: () {
            //_assingRol(user);
          },
          child: Card(
            color: item.completed ? Colors.green : Colors.red,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child:  Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildUserInfo(item),
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                      buildTimeFormatted(item),
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0)),
                      buildLimitProduction(item),
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0)),
                      buildProduced(item),
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0)),
                      buildProductionComplete(item),
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0)),
                      buildProductionAdditional(item),
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0)),
                      buildProductionMissing(item),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildUserInfo(RecordProduction item) {
    String user = item.user != null? item.user.email : null;
    String roltitle = user != null && item.user.rol != null? '('+item.user.rol.name+')' : null;
    Widget userWidget = user != null ?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          user,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              height: 1.0,
              fontWeight: FontWeight.w600),),
        roltitle != null? Text(
          roltitle,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 10.0,
              color: Colors.black,
              height: 1.0,
              fontWeight: FontWeight.w300),)
            :
        Container(height:  0,)
      ],
    )
        : Container(height:  0,);

    return userWidget;
  }

  Widget buildTimeFormatted(RecordProduction record) {
    DateTime now = record.time;
    String formattedDate = now != null? DateFormat('yyyy-MM-dd').format(now) : '';

    return Text(
      formattedDate,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 12.0,
          color: Colors.black,
          height: 1.0,
          fontWeight: FontWeight.w300),
    );
  }

  Widget buildLimitProduction(RecordProduction record) {
    User user = record.user;
    String rolLimit = user != null && user.rol != null? user.rol.production.toString() : '';

    rolLimit = l10n.productionLimit +': ' + rolLimit;
    return Text(
      rolLimit,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 12.0,
          color: Colors.black,
          height: 1.0,
          fontWeight: FontWeight.w300),
    );
  }

  Widget buildProduced(RecordProduction record) {
    int qty = record.qty;
    String title = l10n.produced +': $qty';
    return Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 12.0,
          color: Colors.black,
          height: 1.0,
          fontWeight: FontWeight.w300),
    );
  }

  Widget buildProductionComplete(RecordProduction record) {
    User user = record.user;
    String title = user != null && user.rol != null? user.rol.production.toString() : '';

    title = l10n.completed +': ' + (record.completed ? l10n.yes: l10n.no);
    return Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 12.0,
          color: Colors.black,
          height: 1.0,
          fontWeight: FontWeight.w300),
    );
  }

  Widget buildProductionAdditional(RecordProduction record) {
    User user = record.user;
    String title = user != null && user.rol != null? user.rol.production.toString() : '';

    title = l10n.additional +': ' + record.additional;
    return Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 12.0,
          color: Colors.black,
          height: 1.0,
          fontWeight: FontWeight.w300),
    );
  }

  Widget buildProductionMissing(RecordProduction record) {
    User user = record.user;
    String title = user != null && user.rol != null? user.rol.production.toString() : '';

    title = l10n.missing +': ' + record.missing;
    return Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 12.0,
          color: Colors.black,
          height: 1.0,
          fontWeight: FontWeight.w300),
    );
  }

  void getAllProductionRecords()  {
    try {
      bloc.getAllProductionRecordsForUsers(selectedDate);
    } catch(e) {
      print(e);
    }
  }
}