import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/roles_bloc.dart';
import 'package:confeccionessaapp/di/injector.dart';
import 'package:confeccionessaapp/models/rol.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:confeccionessaapp/ui/custom_widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class AddRolPage extends StatefulWidget {
  final Rol currentRol;

  const AddRolPage({Key key, this.currentRol}) : super(key: key);

  @override
  _AddRolPageState createState() => _AddRolPageState();
}

class _AddRolPageState extends BaseState<AddRolPage, RolesBloc> {
  final TextEditingController _rolNameController = TextEditingController();
  final TextEditingController _rolMaxProductionController = TextEditingController();
  final FocusNode _rolMaxProductionNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if(widget.currentRol != null) {
      _rolNameController.text = widget.currentRol.name;
      _rolMaxProductionController.text = widget.currentRol.production.toString();
    }
  }

  @override
  RolesBloc getBlocInstance() {
    return RolesBloc(Injector().provideUserUseCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(l10n.roles),
        backgroundColor: ApplicationColors().primaryColor,
        actions: <Widget>[
          buildDeleteAction(),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.currentRol != null ? _updateRol() : _saveRol();
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
            buildRolNameTitle(),
            buildRolNameField(),
            buildRolMaxProductionTitle(),
            buildRolMaxProductionField(),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteAction() {
    return widget.currentRol != null ? IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        _deleteRol();
      },
    ) :  Container(
      height: 0.0,
    );
  }

  Widget buildRolNameTitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 21.0, 0.0, 0.0),
      child: Text(l10n.rolName,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              height: 1.0,
              fontWeight: FontWeight.w300)),
    );
  }

  Widget buildRolNameField() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
      child: TextField(
        controller: _rolNameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        onSubmitted: (value) {
          FocusScope.of(context).requestFocus(_rolMaxProductionNode);
        },
        cursorColor: Color(0xFF1a1a1a),
        style: TextStyle(
          color: Color(0xFF1a1a1a),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildRolMaxProductionTitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: Text(l10n.rolMaxProduction,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              height: 1.0,
              fontWeight: FontWeight.w300)),
    );
  }

  Widget buildRolMaxProductionField() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
      child: TextField(
        controller: _rolMaxProductionController,
        focusNode: _rolMaxProductionNode,
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

  void _saveRol() async {
    if(_rolNameController.text.trim() == '' || _rolMaxProductionController.text.trim() == '') {
      MessageAlertDialog().showMessage(context, l10n.message, l10n.alertEmptyField);
      return;
    }

    await bloc.addRol(_rolNameController.text.trim(), _rolMaxProductionController.text.trim()).then((result) {
      if (result != null) {
        Navigator.pop(context);
      }
    });
  }

  void _updateRol() async {
    await bloc.updateRol(_rolNameController.text.trim(), _rolMaxProductionController.text.trim()).then((result) {
      if (result != null) {
        Navigator.pop(context);
      }
    });
  }

  void _deleteRol() async {
    await bloc.deleteRol(widget.currentRol.uuid).then((result) {
      if (result != null) {
        Navigator.pop(context);
      }
    });
  }
}