import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/model/user.dart';
//import 'package:urban_eats/model/usercopy.dart';

import 'package:urban_eats/notifier/auth_notifier.dart';
import 'package:urban_eats/screens/signin.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

User _user = User();

class _SignupState extends State<Signup> {
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userName = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
  User _user = User();
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    signup(_user, authNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        )),
                    Container(
                        padding: EdgeInsets.fromLTRB(134.0, 110.0, 0.0, 0.0),
                        child: Text(
                          '_',
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Username is Required';
                              }
                              if (val.length < 11) {
                                return 'The username character is less than the limit ';
                              }
                              return null;
                            },
                            controller: _userName,
                            decoration: InputDecoration(
                              labelText: 'USERNAME',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple)),
                            ),
                            cursorColor: Colors.deepPurple,
                            keyboardType: TextInputType.text,
                            onSaved: (String value) {
                              _user.displayName = value;
                            },
                          ),
                          TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple)),
                            ),
                            cursorColor: Colors.deepPurple,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Email is required';
                              }

                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              _user.email = value;
                            },
                          ),
                          TextFormField(
                            controller: _password,
                            decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple)),
                            ),
                            cursorColor: Colors.deepPurple,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password is required';
                              }

                              if (value.length < 5 || value.length > 20) {
                                return 'Password must be betweem 5 and 20 characters';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              _user.password = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35.0),
                    GestureDetector(
                      onTap: () {
                        _submitForm();
                      },
                      child: Container(
                        height: 50.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(25),
                          shadowColor: Colors.deepPurpleAccent,
                          color: Colors.deepPurple,
                          elevation: 7.0,
                          child: Center(
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signin()));
                      },
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple,
                                  style: BorderStyle.solid,
                                  width: 2.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Icon(Icons.arrow_back_ios),
                              ),
                              SizedBox(width: 10.0),
                              Center(
                                child: Text("Back to Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  // void _emailSignUp(
  //     {String userName,
  //     String email,
  //     String password,
  //     BuildContext context}) async {
  //   if (_formKey.currentState.validate()) {
  //     try {
  //       SystemChannels.textInput.invokeMethod('TextInput.hide');
  //       await _changeLoadingVisible();
  //       //need await so it has chance to go through error if found.
  //       await Auth.signUp(email, password).then((uID) {
  //         Auth.addUserSettingsDB(new User(
  //           userId: uID,
  //           email: email,
  //           userName: userName,
  //         ));
  //       });
  //       //now automatically login user too
  //       //await StateWidget.of(context).logInUser(email, password);
  //       await Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Signin()));
  //     } catch (e) {
  //       _changeLoadingVisible();
  //       print("Sign Up Error: $e");
  //       String exception = Auth.getExceptionText(e);
  //       Flushbar(
  //         title: "Sign Up Error",
  //         message: exception,
  //         duration: Duration(seconds: 5),
  //       )..show(context);
  //     }
  //   } else {
  //     setState(() => _autoValidate = true);
  //   }
  // }
}
