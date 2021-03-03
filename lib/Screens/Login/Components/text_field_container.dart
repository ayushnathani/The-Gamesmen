import 'package:flutter/material.dart';

import '../../../constraints.dart';

class TextfieldContainer extends StatelessWidget {
  final Widget child;
  const TextfieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.80,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: kprimarylightcolor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
