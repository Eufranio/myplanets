import 'package:flutter/material.dart';
import 'ui/views/login.dart';
import 'ui/views/menu.dart';
import 'ui/views/list_entities.dart';
import 'package:provider/provider.dart';
import 'AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
            builder: (context) => FutureBuilder(
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
            )
        );
      case '/login' :
        return MaterialPageRoute(
            builder: (_)=> LoginScreen()
        ) ;
      case '/listEntities' :
        return MaterialPageRoute(
            builder: (_) => ListEntitiesScreen()
        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}