import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:the_gamesman/Screens/Homescreen/homescreen.dart';
import 'package:the_gamesman/Screens/Login/Components/Roundedpasswordfield.dart';
import 'package:the_gamesman/Screens/Login/Components/Roundedtextfield.dart';
import 'package:the_gamesman/Screens/Login/Components/alreadyhaveanaccountcheck.dart';
import 'package:the_gamesman/Screens/Login/Components/text_field_container.dart';
import 'package:the_gamesman/Screens/Signup/components/Ordivider.dart';
import 'package:the_gamesman/Screens/Signup/components/background.dart';
import 'package:the_gamesman/Screens/Signup/components/socialicon.dart';
import 'package:the_gamesman/Screens/userprovider.dart';
import 'package:the_gamesman/Screens/welcome/components/Roundedbutton.dart';
import 'package:the_gamesman/constraints.dart';

class Signupscreen extends StatefulWidget {
  @override
  _SignupscreenState createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  String email = '';

  String pass = '';

  String name = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userprovider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SvgPicture.asset("assets/icons/signup.svg",
                    height: size.height * 0.4),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextfieldContainer(
                  child: TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Name";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: kprimarycolor,
                      ),
                      hintText: "Your Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedTextfield(
                  hint: "Your Email",
                  icon: Icons.person,
                  email: email,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                RoundedPasswordfield(
                  pass: pass,
                  onChanged: (value) {
                    setState(() {
                      pass = value;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Roundedbutton(
                  text: 'SIGN UP',
                  textcolor: kprimarylightcolor,
                  color: kprimarycolor,
                  press: () async {
                    //      validateForm();
                    if (formkey.currentState.validate()) {
                      if (!await user.signup(name, email, pass)) {
                        _key.currentState.showSnackBar(
                            SnackBar(content: Text("Sign up Failed")));
                        return;
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Homescreen(),
                          ));
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Alreadyhaveanaccountcheck(
                  login: false,
                  press: () {
                    Navigator.of(context).pushNamed("./Screen1");
                  },
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Ordivider(),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Socialicon(
                      iconsrc: 'assets/icons/facebook.svg',
                      press: () {},
                    ),
                    Socialicon(
                      iconsrc: 'assets/icons/google-plus.svg',
                      press: () {},
                    ),
                    Socialicon(
                      iconsrc: 'assets/icons/twitter.svg',
                      press: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
