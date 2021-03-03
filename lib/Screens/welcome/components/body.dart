import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_gamesman/Screens/welcome/components/background.dart';

import 'package:the_gamesman/constraints.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('The Gamesman',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset("assets/icons/chat.svg",
                height: size.height * 0.45),
            SizedBox(
              height: size.height * 0.03,
            ),
            Roundedbutton(
              text: 'LOGIN',
              press: () {
                Navigator.of(context).pushNamed("./Screen1");
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Roundedbutton(
              text: 'SIGN UP',
              color: kprimarylightcolor,
              textcolor: Colors.black,
              press: () {
                Navigator.of(context).pushNamed("./Screen2");
              },
            )
          ],
        ),
      ),
    );
  }
}

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
