import 'package:flutter/material.dart';
import 'package:the_gamesman/constraints.dart';

class Ordivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Text(
            "Or",
            style: TextStyle(fontWeight: FontWeight.bold, color: kprimarycolor),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
        child: Divider(
      color: kprimarycolor,
      height: 1.5,
    ));
  }
}
