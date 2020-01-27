import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:planets/AuthService.dart';
import 'package:planets/ui/views/info/planet/new_planet.dart';

class MainScreen extends StatefulWidget {

  final FirebaseUser currentUser;

  MainScreen(this.currentUser);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var description = Text(
      //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus augue odio, suscipit vitae pharetra vel, malesuada eu enim. Phasellus ut dui vel quam vulputate pretium. Nullam suscipit neque est. Cras consequat porta pellentesque. Pellentesque eget tincidunt enim',
      'Bem vindo ${widget.currentUser.email}',
      style: TextStyle(fontSize: 20, color: Colors.white),
      textAlign: TextAlign.center,
    );

    TextStyle buttonStyle = TextStyle(
        color: Colors.deepPurple,
        fontSize: 18,
        fontWeight: FontWeight.bold
    );

    var createButton = RaisedButton(
      color: Colors.white,
      child: Align(
        child: Text('Criar', style: buttonStyle),
        alignment: Alignment.bottomCenter,
        heightFactor: 3.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => EditPlanetScreen(planet: null)
        ));
      },
    );

    var listButton = RaisedButton(
      color: Colors.white,
      child: Align(
        child: Text('Listar', style: buttonStyle),
        alignment: Alignment.bottomCenter,
        heightFactor: 3.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        Navigator.pushNamed(context, '/listEntities');
      },
    );

    var accountButton = RaisedButton(
      color: Colors.white,
      child: Align(
        child: Text('Conta', style: buttonStyle),
        alignment: Alignment.bottomCenter,
        heightFactor: 3.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {},
    );

    var logoutButton = IconButton(
      color: Colors.white,
      icon: Icon(Icons.exit_to_app),
      onPressed: () async {
        await Provider.of<AuthService>(context, listen: false).logout();
      },
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg-menu.png'),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
                height: 340,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40, left: 10),
                    child: logoutButton
                  ),
                )
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    description
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox.fromSize(child: createButton, size: Size.square(100)),
                  SizedBox.fromSize(child: listButton, size: Size.square(100)),
                  SizedBox.fromSize(child: accountButton, size: Size.square(100))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}