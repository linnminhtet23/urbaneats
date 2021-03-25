import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:urban_eats/screens/signin.dart';

class ForgotPassword extends StatefulWidget {
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              'assets/images/default.png',
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      //validator: Validator.validateEmail,
      decoration: InputDecoration(
        // prefixIcon: Padding(
        //   padding: EdgeInsets.only(left: 5.0),
        //   child: Icon(
        //     Icons.email,
        //     color: Colors.grey,
        //   ), // icon is 48px widget.
        // ), // icon is 48px widget.
        labelText: 'EMAIL',
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple)),

        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final forgotPasswordButton = GestureDetector(
      onTap: () {
        //_forgotPassword(email: _email.text, context: context);
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
              'Forgot Password',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
    SizedBox(height: 35.0);

    final signInLabel = GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Signin()));
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
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  logo,
                  SizedBox(height: 48.0),
                  email,
                  SizedBox(height: 20.0),
                  forgotPasswordButton,
                  SizedBox(height: 20.0),
                  signInLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  // void _forgotPassword({String email, BuildContext context}) async {
  //   SystemChannels.textInput.invokeMethod('TextInput.hide');
  //   if (_formKey.currentState.validate()) {
  //     try {
  //       await _changeLoadingVisible();
  //       await Auth.forgotPasswordEmail(email);
  //       await _changeLoadingVisible();
  //       Flushbar(
  //         title: "Password Reset Email Sent",
  //         message:
  //             'Check your email and follow the instructions to reset your password.',
  //         duration: Duration(seconds: 20),
  //       )..show(context);
  //     } catch (e) {
  //       _changeLoadingVisible();
  //       print("Forgot Password Error: $e");
  //       String exception = Auth.getExceptionText(e);
  //       Flushbar(
  //         title: "Forgot Password Error",
  //         message: exception,
  //         duration: Duration(seconds: 10),
  //       )..show(context);
  //     }
  //   } else {
  //     setState(() => _autoValidate = true);
  //   }
  // }
}
