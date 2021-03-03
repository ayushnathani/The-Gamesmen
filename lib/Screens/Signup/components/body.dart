import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:the_gamesman/Screens/Homescreen/homescreen.dart';
import 'package:the_gamesman/Screens/Login/Components/Roundedpasswordfield.dart';
import 'package:the_gamesman/Screens/Login/Components/Roundedtextfield.dart';
import 'package:the_gamesman/Screens/Login/Components/alreadyhaveanaccountcheck.dart';
import 'package:the_gamesman/Screens/Signup/components/Ordivider.dart';
import 'package:the_gamesman/Screens/Signup/components/background.dart';
import 'package:the_gamesman/Screens/Signup/components/socialicon.dart';
import 'package:the_gamesman/Screens/Signup/users.dart';
import 'package:the_gamesman/Screens/userprovider.dart';
import 'package:the_gamesman/Screens/welcome/components/body.dart';
import 'package:the_gamesman/constraints.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formkey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  // final FirebaseAuth mAuth = FirebaseAuth.instance;
  // UserServices userservices = UserServices();

  String email = '';
  String pass = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userprovider>(context);
    Size size = MediaQuery.of(context).size;
    return user.status == Status.Authenticating
        ? CircularProgressIndicator()
        : Background(
            key: _key,
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
                    RoundedTextfield(
                      hint: "Your Name",
                      icon: Icons.person,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedTextfield(
                      hint: "Your Email",
                      icon: Icons.person,
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
          );
  }

  // Future validateForm() async {
  //   FormState formState = formkey.currentState;
  //   if (formState.validate()) {
  //     formState.reset();

  //     FirebaseUser user = await mAuth.currentUser();
  //     if (user != null) {
  //       mAuth
  //           .createUserWithEmailAndPassword(email: email, password: pass)
  //           .then((user) => {
  //                 Firestore.instance.collection("users").add({
  //                   "email": email,
  //                   "userId": user.user.uid,
  //                 })
  //               })
  //           .catchError((e) => {print(e.toString())});
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => Homescreen()));
  //     }
  //   }
  // }
}
