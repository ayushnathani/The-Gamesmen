import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:the_gamesman/Screens/Login/Components/Roundedpasswordfield.dart';
import 'package:the_gamesman/Screens/Login/Components/Roundedtextfield.dart';
import 'package:the_gamesman/Screens/Login/Components/alreadyhaveanaccountcheck.dart';
import 'package:the_gamesman/Screens/Login/Components/background.dart';
import 'package:the_gamesman/Screens/login/components/body.dart';
import 'package:the_gamesman/Screens/userprovider.dart';
import 'package:the_gamesman/Screens/welcome/components/Roundedbutton.dart';
import 'package:the_gamesman/constraints.dart';

class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  String email = '';
  String pass = '';
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
                Text('Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SvgPicture.asset("assets/icons/login.svg",
                    height: size.height * 0.35),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedTextfield(
                  hint: "Your Email",
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  icon: Icons.person,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                RoundedPasswordfield(
                  onChanged: (value) {
                    pass = value;
                  },
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Roundedbutton(
                  text: 'LOGIN',
                  textcolor: kprimarylightcolor,
                  color: kprimarycolor,
                  press: () async {
                    if (formkey.currentState.validate()) {
                      if (!await user.signin(email, pass)) {
                        _key.currentState.showSnackBar(
                            SnackBar(content: Text("Sign in Failed")));
                      }
                    }

                    // try {
                    //   final user = mAuth.signInWithEmailAndPassword(
                    //       email: email, password: pass);
                    //   if (user != null) {
                    //     Navigator.of(context).pushNamed('./Screen3');
                    //   }
                    // } catch (e) {
                    //   e.message();
                    // }
                  },
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Alreadyhaveanaccountcheck(
                  press: () {
                    Navigator.of(context).pushNamed("./Screen2");
                  },
                ),
                FlatButton(
                  onPressed: () {
                    // handleSignin();
                  },
                  child: Text(
                    'Google',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: kprimarycolor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
