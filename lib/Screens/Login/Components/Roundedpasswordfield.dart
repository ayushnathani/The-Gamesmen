import 'package:flutter/material.dart';
import 'package:the_gamesman/Screens/Login/Components/text_field_container.dart';
import 'package:the_gamesman/constraints.dart';

class RoundedPasswordfield extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final pass;

  const RoundedPasswordfield({
    this.onChanged,
    this.pass,
  });

  @override
  _RoundedPasswordfieldState createState() => _RoundedPasswordfieldState();
}

class _RoundedPasswordfieldState extends State<RoundedPasswordfield> {
  @override
  Widget build(BuildContext context) {
    return TextfieldContainer(
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter password";
          } else if (value.length < 6) {
            return "Password should be grater than 6";
          }
        },
        onChanged: widget.onChanged,
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Enter Password",
            icon: Icon(
              Icons.lock,
              color: kprimarycolor,
            ),
            suffixIcon: Icon(
              Icons.visibility,
              color: kprimarycolor,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
