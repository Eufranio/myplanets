import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {

  final AssetImage image;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry align;
  final double expandBox;
  final Function onPressed;

  PopupMenuButton popupButton;

  ImageButton({
    @required this.image,
    @required this.child,
    @required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.align = Alignment.center,
    this.expandBox = double.infinity,
    this.popupButton});

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
        onPressed: this.onPressed,
        onLongPress: () {
          if (this.popupButton == null) return;

          final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
          final RenderBox button = context.findRenderObject() as RenderBox;
          final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
          final RelativeRect position = RelativeRect.fromRect(
            Rect.fromPoints(
              button.localToGlobal(this.popupButton.offset, ancestor: overlay),
              button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
            ),
            Offset.zero & overlay.size,
          );
          final List<PopupMenuEntry> items = this.popupButton.itemBuilder(context);
          // Only show the menu if there is something to show
          if (items.isNotEmpty) {
            showMenu(
              context: context,
              elevation: this.popupButton.elevation ?? this.popupButton.elevation,
              items: items,
              initialValue: this.popupButton.initialValue,
              position: position,
              shape: this.popupButton.shape ?? popupMenuTheme.shape,
              color: this.popupButton.color ?? popupMenuTheme.color,
              captureInheritedThemes: this.popupButton.captureInheritedThemes,
            ).then<void>((newValue) {
              if (newValue == null) {
                return null;
              } else if (this.popupButton.onSelected != null)
                this.popupButton.onSelected(newValue);
            });
          }
        },
      ),
    );
  }
}