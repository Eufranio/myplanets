import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:planets/AuthService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.bold
    );

    var emailField = TextFormField(
      onSaved: (value) => _email = value,
      keyboardType: TextInputType.emailAddress,
      style: style,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: "Login",
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    var passwordField = TextFormField(
        onSaved: (value) => _password = value,
        obscureText: true,
        style: style,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: "Senha",
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        )
    );

    var button = RaisedButton(
      color: Colors.deepPurple[700],
      child: Text('Login', style: style),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () async {
        final form = _formKey.currentState;
        form.save();

        // Validate will return true if is valid, or false if invalid.
        try {
          FirebaseUser result =
              await Provider.of<AuthService>(context, listen: false).loginUser(
              email: _email, password: _password);
          print(result);
        } on AuthException catch (error) {
          // handle the firebase specific error
          return _buildErrorDialog(context, error.message);
        } on Exception catch (error) {
          // gracefully handle anything else that might happen..
          return _buildErrorDialog(context, error.toString());
        }
      },
    );

    var forgotPassword = FlatButton(
      child: Text('Esqueci a senha!',
          style: style.copyWith(color: Colors.white.withOpacity(0.5))),
      onPressed: () {},
    );

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg-login.png'),
                  fit: BoxFit.cover
              )
          ),
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 80),
                    Stack(
                      children: <Widget>[
                        Align(
                          child: SizedBox(
                            height: 300,
                            child: Image.asset('assets/planet.png'),
                          ),
                        ),
                        Positioned(
                          right: 40,
                          top: 150,
                          child: SizedBox(
                            height: 65,
                            child: Image.asset('assets/myplanets.png'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 80),
                    SizedBox(
                      height: 55,
                      width: 280,
                      child: emailField,
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                        height: 55,
                        width: 280,
                        child: passwordField
                    ),
                    SizedBox(
                      width: 300,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          forgotPassword
                        ],
                      ),
                    ),
                    SizedBox(height: 80),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: button,
                    ),
                    SizedBox(height: 30)
                  ],
                ),),
            ),
          ),
        )
    );
  }
}

Future _buildErrorDialog(BuildContext context, _message) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Error Message'),
        content: Text(_message),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}