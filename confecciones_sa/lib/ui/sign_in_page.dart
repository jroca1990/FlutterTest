import 'package:confeccionessaapp/app/settings/application.dart';
import 'package:confeccionessaapp/app/settings/application_assets.dart';
import 'package:confeccionessaapp/app/settings/application_colors.dart';
import 'package:confeccionessaapp/blocs/sign_in_bloc.dart';
import 'package:confeccionessaapp/di/injector.dart';
import 'package:confeccionessaapp/models/constants.dart';
import 'package:confeccionessaapp/models/exceptions/app_exception.dart';
import 'package:confeccionessaapp/ui/admin_home_page.dart';
import 'package:confeccionessaapp/ui/base_state.dart';
import 'package:confeccionessaapp/ui/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

bool isTextPasswordObscure = true;

class _SignInPageState extends BaseState<SignInPage, SignInBloc> {
  final FocusNode _passwordNode = FocusNode();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSignIn = true;
  bool isEmailValid = true;
  String _errorMessage = '';
  bool _asAdmin = false;

  @override
  SignInBloc getBlocInstance() {
    return SignInBloc(Injector().provideSecurityUseCase());
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(
              children: <Widget>[
                showForm(),
              ],
            )
        )
    );
  }

  Widget showForm() {
    return Container(
      height: 560,
      margin: EdgeInsets.fromLTRB(33.0, 26.0, 33.0, 20.0),
      child: Center(
          child:Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(32.0, 40.0, 32.0, 0.0),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  buildCompanyLogo(),
                  showErrorMessage(),
                  buildUserNameTitle(),
                  buildUserNameField(),
                  buildPasswordTitle(),
                  buildPasswordField(),
                  buildCheckBoxAsAdmin(),
                  buildSignInButton(),
                  buildLogInOption(),
                ],
              ),
            ),
          )),

    );
  }

  Widget buildCompanyLogo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Center(
        child: Container(
          height: 94,
          width: 150,
          child: Image.asset(ApplicationAssets.logo),
        ),
      ),
    );
  }

  Widget buildUserNameTitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 21.0, 0.0, 0.0),
      child: Text(l10n.userName,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFFcbcbcb),
              height: 1.0,
              fontWeight: FontWeight.w300)),
    );
  }

  Widget buildUserNameField() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
      child: TextField(
        controller: _userController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        onSubmitted: (value) {
          FocusScope.of(context).requestFocus(_passwordNode);
        },
        onChanged: (value) {
          _validateEmail(value);
        } ,
        cursorColor: Color(0xFF1a1a1a),
        style: TextStyle(
          color: Color(0xFF1a1a1a),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildPasswordTitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 21.0, 0.0, 0.0),
      child: Text(l10n.password,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFFcbcbcb),
              height: 1.0,
              fontWeight: FontWeight.w300)),
    );
  }

  Widget buildPasswordField() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
      child: TextField(
        controller: _passwordController,
        focusNode: _passwordNode,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        cursorColor: Color(0xFF1a1a1a),
        obscureText: true,
        style: TextStyle(
          color: Color(0xFF1a1a1a),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildCheckBoxAsAdmin() {
    if (!_isSignIn) {
      return Padding(
          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: new Center(
              child:  new CheckboxListTile(
                value: _asAdmin,
                onChanged: _valueAsAdminChanged,
                title: new Text(l10n.signUpAdmin),
                controlAffinity: ListTileControlAffinity.leading,
                secondary: new Icon(Icons.verified_user),
                activeColor: ApplicationColors().secondaryColor,
              )
          ));
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  Widget buildSignInButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(6.0, 35.0, 6.0, 0.0),
        child: SizedBox(
            height: 46.0,
            child: RaisedButton(
              color: ApplicationColors().primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Text(_isSignIn ? l10n.signIn : l10n.signUp,
                  style: TextStyle(
                      fontSize: 18.0, color: Colors.white,
                      fontWeight: FontWeight.w300
                  )),
              onPressed: _isSignIn ? _signIn : _signUp,
            )
        )
    );
  }

  Widget buildLogInOption() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
      child: FlatButton(
          child: Text(
            _isSignIn ? l10n.createAccount : l10n.haveAccount,
            style: TextStyle(
                fontSize: 15.0,
                color: ApplicationColors().secondaryColor,
                fontWeight: FontWeight.w300),
          ),
          onPressed: toggleFormMode),
    ) ;
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
            child: Text(
              _errorMessage,
              style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.red,
                  height: 1.0,
                  fontWeight: FontWeight.w300),
            ),
      ) ;
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  void toggleFormMode() {
    setState(() {
      _asAdmin = false;
      _isSignIn = !_isSignIn;
    });
  }

  void _validateEmail(String value) {
    var isValid = true;
    if (value.length != 0) {
      if (RegExp(Constants.EMAIL_REGEX).hasMatch(value)) {
        isValid = true;
      } else {
        isValid = false;
      }
    }
    setState(() {
      isEmailValid = isValid;

      if(!isValid) {
        _errorMessage = l10n.emailRegexInvalid;
      } else {
        _errorMessage = '';
      }

      showErrorMessage();
    });
  }

  void _valueAsAdminChanged(bool value) => setState(() => _asAdmin = value);

  void _signIn() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var user = _userController.text.trim();
    var password = _passwordController.text.trim();

    try {
      await bloc.signIn(user, password).then((result) {
        if (result != null) {
          Application().applicationUser = result;

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => result.type == "admin" ? AdminHomePage() : HomePage()),
                (route) => false,
          );
        } else {
          showBaseError();
        }
      });
    } catch (e) {
      setState(() {
        switch(e.code) {
          case ErrorsCode.USER_NOT_EXIST: {
            _errorMessage = l10n.userNotExist;
          }
          break;

          case ErrorsCode.USER_INVALID_PASSWORD: {
            _errorMessage = l10n.invalidPassword;
          }
          break;

          default :
            _errorMessage = e.toString();
            break;
        }
      });
    }
  }

  void _signUp() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var user = _userController.text.trim();
    var password = _passwordController.text.trim();

    try {
      await bloc.signUp(user, password, _asAdmin).then((result) {
        if (result != null) {
          bloc.getAuthenticationInfo(user).then((result) {
            Application().applicationUser = result;

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => result.type == "admin" ? AdminHomePage() : HomePage()),
                  (route) => false,
            );
          });
        } else {
          showBaseError();
        }
      });
    } catch (e) {
      setState(() {
        switch(e.code) {
          case ErrorsCode.USER_EXIST: {
            // statements;
            _errorMessage = l10n.userExist;
          }
          break;

          default :
            _errorMessage = e.toString();
            break;
        }
      });
    }
  }

  void showBaseError() {
    setState(() {
      _errorMessage = l10n.baseErrorMessage;
    });
  }
}
