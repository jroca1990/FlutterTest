import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/users_bloc.dart';
import 'package:confeccionessaapp/di/injector.dart';
import 'package:confeccionessaapp/models/user.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:confeccionessaapp/ui/roles_page.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends BaseState<UsersPage, UsersBloc> {

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  UsersBloc getBlocInstance() {
    return UsersBloc(Injector().provideUserUseCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(l10n.roles),
        backgroundColor: ApplicationColors().primaryColor,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<List<User>>(
          stream: bloc.users,
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
                        .map( (f) => buildUserItem(f)
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

  Widget buildUserItem(User user) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: GestureDetector(
          onTap: () {
            _assingRol(user);
          },
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        height: 1.0,
                        fontWeight: FontWeight.w300),
                  ),
                  user.rol != null? Text(
                     user.rol.name ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.black,
                        height: 1.0,
                        fontWeight: FontWeight.w300),
                  ) : Container(height: 0.0,)
                ],
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
              )
            ],
          ),
        ));
  }

  void _assingRol(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RolesPage(currentUser: user),
      ),
    ).then((result) {
      setState(() {
        loadUsers();
      });
    });
  }

  void loadUsers() {
    bloc.getAllUsers();
  }
}