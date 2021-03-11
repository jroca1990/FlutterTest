import 'dart:io';
import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/production_records_bloc.dart';
import 'package:confeccionessaapp/di/injector.dart';
import 'package:confeccionessaapp/models/record_production.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductionRecordsPage extends StatefulWidget {

  @override
  _ProductionRecordsPageState createState() => _ProductionRecordsPageState();
}

class _ProductionRecordsPageState extends BaseState<ProductionRecordsPage, ProductionRecordsBloc> {

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
        title: new Text(l10n.productionRecords),
        backgroundColor: ApplicationColors().primaryColor,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<List<RecordProduction>>(
          stream: bloc.productionRecords,
          builder: (context, snapshot)
          {
            return snapshot.data == null?
            Container(
              height: 0.0,
            ):
            Padding (
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
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
    );
  }

  Widget buildItem(RecordProduction item) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: GestureDetector(
          onTap: () {
            //_assingRol(user);
          },
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildTimeFormatted(item),
                  Text(
                    l10n.qty +' ('+item.user.rol.name +'): '+ item.qty.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        height: 1.0,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              SizedBox(width: 10,),
              buildImage(item),
            ],
          ),
        ));
  }

  Widget buildImage(RecordProduction item) {
    return item.imagePath != null && item.imagePath != ''?
    Center(child: Container(height: 100, width:  100,
        child:
        Image.file(File(item.imagePath))),)
        : Container(height: 0,);

  }

  Widget buildTimeFormatted(RecordProduction record) {
    DateTime now = record.time;
    String formattedDate = now != null? DateFormat('yyyy-MM-dd – kk:mm').format(now) : '';

    return Text(
      formattedDate,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          height: 1.0,
          fontWeight: FontWeight.w300),
    );
  }

  void getAllProductionRecords()  {
    try {
      bloc.getAllProductionRecords();
    } catch(e) {
      print(e);
    }
  }
}