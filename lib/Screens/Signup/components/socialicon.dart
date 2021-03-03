import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_gamesman/constraints.dart';

class Socialicon extends StatelessWidget {
  final String iconsrc;
  final Function press;
  const Socialicon({
    Key key,
    this.iconsrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: kprimarylightcolor),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconsrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
