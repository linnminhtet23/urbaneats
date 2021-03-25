import 'package:flutter/material.dart';
import 'package:urban_eats/model/user.dart';
import 'package:urban_eats/notifier/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';

enum AuthMode { Signup, Login }

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  User _user = User();
  /////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////////
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.Login) {
      login(_user, authNotifier);
    } else {
      signup(_user, authNotifier);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Widget _buildDisplayNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "USERNAME",
        labelStyle: TextStyle(color: Colors.white54),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      
      onSaved: (String value) {
        _user.displayName = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.white54),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      validator: (String value) {
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
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.white54),
      ),
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      obscureText: true,
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 5 || value.length > 8) {
          return 'Password must be betweem 5 and 8 characters';
        }

        return null;
      },
      onSaved: (String value) {
        _user.password = value;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: Colors.white54),
      ),
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Passwords do not match';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building login screen");

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        //decoration: BoxDecoration(color: Color(0xff34056D)),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                              child: Text(
                                'Urban Eats',
                                style: TextStyle(
                                    fontSize: 65.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              )),
                          Container(
                              padding:
                                  EdgeInsets.fromLTRB(183.0, 30.0, 0.0, 0.0),
                              child: Text(
                                '_',
                                style: TextStyle(
                                    fontSize: 65.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                              )),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 32),
                    _authMode == AuthMode.Signup
                        ? _buildDisplayNameField()
                        : Container(),
                    _buildEmailField(),
                    _buildPasswordField(),
                    _authMode == AuthMode.Signup
                        ? _buildConfirmPasswordField()
                        : Container(),
                    SizedBox(height: 32),
                    ButtonTheme(
                      minWidth: 200,
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.Login
                                ? AuthMode.Signup
                                : AuthMode.Login;
                          });
                        },
                      ),
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ),
                    SizedBox(height: 16),
                    ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        onPressed: () => _submitForm(),
                        child: Text(
                          _authMode == AuthMode.Login ? 'Login' : 'Signup',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
