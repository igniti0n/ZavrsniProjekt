import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    @required this.theme,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final TextTheme theme;
  final Widget text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 4,
      splashColor: Colors.white,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: text,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent[400],
          gradient: RadialGradient(colors: [
            Colors.blue[700],
            Colors.blue[600],
            Colors.lightBlue[200],
          ], radius: 6, center: Alignment(0.0, 0.0)),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 0.5,
              offset: Offset(0.0, 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
