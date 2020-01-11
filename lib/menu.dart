import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      onPressed: () {},
    );

    var listButton = RaisedButton(
      color: Colors.white,
      child: Align(
        child: Text('Listar', style: buttonStyle),
        alignment: Alignment.bottomCenter,
        heightFactor: 3.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {},
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
            SizedBox(height: 340),
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