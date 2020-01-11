import 'package:flutter/material.dart';
import 'login.dart';
import 'menu.dart';
import 'AuthService.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(
    ChangeNotifierProvider<AuthService>(
        child: MyApp(),
        create: (BuildContext context) => AuthService()
    )
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Montserrat',
      ),
      home: FutureBuilder(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }
            return snapshot.hasData ? MainScreen(snapshot.data) : LoginScreen();
          }
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
              alignment: Alignment(0.0, 0.0),
            ),
          );
        }
      ),
    );
  }
}