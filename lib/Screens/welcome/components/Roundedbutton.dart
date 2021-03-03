import 'package:flutter/material.dart';
import 'package:the_gamesman/constraints.dart';

class Roundedbutton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textcolor;
  const Roundedbutton(
      {Key key,
      this.text,
      this.press,
      this.color = kprimarycolor,
      this.textcolor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: FlatButton(
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textcolor),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            color: color,
          )),
    );
  }
}
