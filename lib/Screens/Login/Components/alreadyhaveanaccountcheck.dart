import 'package:flutter/material.dart';
import 'package:the_gamesman/constraints.dart';

class Alreadyhaveanaccountcheck extends StatelessWidget {
  final bool login;
  final Function press;
  const Alreadyhaveanaccountcheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? 'Dont have an account?' : "Already have an account?",
          style: TextStyle(color: kprimarycolor),
        ),
        GestureDetector(
            onTap: press,
            child: Text(
              login ? 'Sign Up' : 'Log In',
              style:
                  TextStyle(color: kprimarycolor, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
