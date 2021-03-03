import 'package:flutter/material.dart';
import 'package:the_gamesman/Screens/Login/Components/text_field_container.dart';
import 'package:the_gamesman/constraints.dart';

class RoundedTextfield extends StatefulWidget {
  final String hint;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String email;

  const RoundedTextfield({
    this.hint,
    this.icon,
    this.onChanged,
    this.email,
  });

  @override
  _RoundedTextfieldState createState() => _RoundedTextfieldState();
}

class _RoundedTextfieldState extends State<RoundedTextfield> {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return TextfieldContainer(
      child: TextFormField(
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter Email";
          } else if (!isValidEmail()) {
            return "Check ur email";
          }
        },
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kprimarycolor,
          ),
          hintText: widget.hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
