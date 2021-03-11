import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/roles_bloc.dart';
import 'package:confeccionessaapp/di/injector.dart';
import 'package:confeccionessaapp/models/rol.dart';
import 'package:confeccionessaapp/models/user.dart';
import 'package:confeccionessaapp/ui/add_rol_page.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:flutter/material.dart';

class RolesPage extends StatefulWidget {
  final User currentUser;

  const RolesPage({Key key, this.currentUser}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends BaseState<RolesPage, RolesBloc> {

  @override
  void initState() {
    super.initState();
    loadRoles();
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
          buildAddAction()
          ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<List<Rol>>(
          stream: bloc.roles,
          builder: (context, snapshot)
          {
            return snapshot.data == null?
            Container(
              height: 0.0,
            ): Padding (
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(snapshot.data
                        .map( (f) => buildRolItem(f)
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

  Widget buildAddAction() {
    return widget.currentUser == null ? IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        _addRol();
      },
    ) :  Container(
      height: 0.0,
    );
  }

  Widget buildRolItem(Rol rol) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: GestureDetector(
          onTap: () {
            widget.currentUser != null ? _assignRol(rol) : _editRol(rol);
          },
          child: Row(
            children: <Widget>[
              Text(
                rol.name,
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
        ));
  }

  void _addRol() {
    if(widget.currentUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AddRolPage(),
        ),
      ).then((result) {
        setState(() {
          loadRoles();
        });
      });
    }
  }

  void _editRol(Rol rol) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddRolPage(currentRol: rol),
      ),
    ).then((result) {
      setState(() {
        loadRoles();
      });
    });
  }

  void _assignRol(Rol rol) async {
    try {
      widget.currentUser.rol = rol;
      await bloc.assignRol(widget.currentUser).then((result) {
        Navigator.pop(context);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void loadRoles() {
    bloc.getAllRoles();
  }
}