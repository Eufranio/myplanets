import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.bold
    );

    var emailField = TextField(
      obscureText: false,
      style: style,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: "Login",
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    var passwordField = TextField(
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
      onPressed: () {},
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
                    /*Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
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
                              width: 310,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  forgotPassword
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: button,
                            ),
                            SizedBox(height: 30)
                          ],
                        ),
                      ),
                    ),*/
                  ],
                )
            ),
          ),
        )
    );
  }
}