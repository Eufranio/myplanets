import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final AssetImage image;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry align;
  final double expandBox;
  final Function onPressed;

  ImageButton({@required this.image, @required this.child, this.padding = EdgeInsets.zero, this.align = Alignment.center, this.expandBox = double.infinity, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        textColor: Colors.white,
        child: Container(
          constraints: BoxConstraints.expand(height: this.expandBox),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: this.image,
                fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding: this.padding,
            child: Align(
              child: this.child,
              alignment: this.align,
              heightFactor: 3.5,
            ),
          ),
        ),
        onPressed: this.onPressed
      ),
    );
  }
}