import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Image.asset("assets/images/signup_top.png"),
            top: 0,
            left: 0,
            width: size.width * 0.2,
          ),
          Positioned(
              child: Image.asset("assets/images/login_bottom.png"),
              right: 0,
              bottom: 0,
              width: size.width * 0.3),
          child,
        ],
      ),
    );
  }
}
