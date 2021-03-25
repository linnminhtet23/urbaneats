import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/model/user.dart';
import 'package:urban_eats/notifier/auth_notifier.dart';

//import 'package:urban_eats/model/user.dart';
import 'package:urban_eats/screens/discover.dart';

import 'package:urban_eats/screens/forgotpassword.dart';
import 'package:urban_eats/screens/signup.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isLoading = false;
  bool isLoginedin = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
  User _user = User();

  //AuthMode _authMode = AuthMode.Login;
  //User _user = User();
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
    //isSignedIn();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      setState() {
        isLoading = true;
      }
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    login(_user, authNotifier);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Discover()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                          'Urban Eats',
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        )),
                    Container(
                        padding: EdgeInsets.fromLTRB(170.0, 110.0, 0.0, 0.0),
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
              padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Form(
                      // autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
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
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  decoration: TextDecoration.underline))),
                    ),
                    SizedBox(height: 25.0),
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
                              'LOGIN',
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
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isLoading ?? true,
              child: Container(
                  color: Colors.white.withOpacity(0.7),
                  child: CircularProgressIndicator()),
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('New User?', style: TextStyle(fontFamily: 'Montserrat')),
                SizedBox(width: 5.0),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Text("Register",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.deepPurple)))
              ],
            )
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

  // void _emailLogin(
  //     {String email, String password, BuildContext context}) async {
  //   if (_formKey.currentState.validate()) {
  //     try {
  //       SystemChannels.textInput.invokeMethod('TextInput.hide');
  //       await _changeLoadingVisible();
  //       //need await so it has chance to go through error if found.
  //       await StateWidget.of(context).logInUser(email, password);
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Discover()));
  //     } catch (e) {
  //       _changeLoadingVisible();
  //       print("Sign In Error: $e");
  //       String exception = Auth.getExceptionText(e);
  //       Flushbar(
  //         title: "Sign In Error",
  //         message: exception,
  //         duration: Duration(seconds: 5),
  //       )..show(context);
  //     }
  //   } else {
  //     setState(() => _autoValidate = true);
  //   }
  // }
  // void isSignedIn() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   preferences = await SharedPreferences.getInstance();
  //   isLoginedin = await _googleSignIn.isSignedIn();
  //   if (isLoginedin = true) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Feed()));
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

}
