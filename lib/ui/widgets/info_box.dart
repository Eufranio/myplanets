import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {

  final Text value;
  final Text title;
  final double size, width, height;

  InfoBox({
    @required this.value,
    this.title,
    this.size = 80,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      width: this.width ?? this.size,
      height: this.height ?? this.size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: this.value
          ),
          this.title == null ? SizedBox.shrink() :
          Align(
            alignment: Alignment.bottomCenter,
            child: this.title,
          ),
        ],
      ),
    );
  }

}