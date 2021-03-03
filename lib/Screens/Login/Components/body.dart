import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:the_gamesman/Screens/Homescreen/homescreen.dart';
import 'package:the_gamesman/Screens/Login/Components/Roundedpasswordfield.dart';
import 'package:the_gamesman/Screens/Login/Components/Roundedtextfield.dart';
import 'package:the_gamesman/Screens/Login/Components/alreadyhaveanaccountcheck.dart';
import 'package:the_gamesman/Screens/Login/Components/background.dart';
import 'package:the_gamesman/Screens/Login/Components/text_field_container.dart';
import 'package:the_gamesman/Screens/userprovider.dart';
import 'package:the_gamesman/Screens/welcome/components/body.dart';
import 'package:the_gamesman/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  // final GoogleSignIn googleSignIn = new GoogleSignIn();
  // final FirebaseAuth mAuth = FirebaseAuth.instance;

  // SharedPreferences preferences;
  // bool loading = false;
  // bool isloggedin = false;
  String email = '';
  String pass = '';

  // @override
  // void initState() {
  //   super.initState();
  //   isSignedIn();
  // }

  // void isSignedIn() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   preferences = await SharedPreferences.getInstance();
  //   isloggedin = await googleSignIn.isSignedIn();

  //   if (isloggedin) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Homescreen()));
  //   }
  //   setState(() {
  //     loading = false;
  //   });
  // }

  // Future handleSignin() async {
  //   preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     loading = true;
  //   });
  //   // GoogleSignInAccount googleuser = await googleSignIn.signIn();
  //   // GoogleSignInAuthentication googleSignInAuthentication =
  //   //     await googleuser.authentication;

  //   GoogleSignInAccount googleUser = await googleSignIn.signIn();
  //   GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleUser.authentication;
  //   AuthCredential credential = GoogleAuthProvider.getCredential(
  //       idToken: googleSignInAuthentication.idToken,
  //       accessToken: googleSignInAuthentication.accessToken);

  //   FirebaseUser firebaseUser =
  //       (await mAuth.signInWithCredential(credential)).user;

  //   if (firebaseUser != null) {
  //     final QuerySnapshot result = await Firestore.instance
  //         .collection("users")
  //         .where("id", isEqualTo: firebaseUser.uid)
  //         .getDocuments();
  //     final List<DocumentSnapshot> documents = result.documents;

  //     if (documents.length == 0) {
  //       Firestore.instance
  //           .collection("users")
  //           .document(firebaseUser.uid)
  //           .setData({
  //         "id": firebaseUser.uid,
  //         "username": firebaseUser.displayName,
  //         "profilepicture": firebaseUser.photoUrl,
  //       });

  //       await preferences.setString("id", firebaseUser.uid);
  //       await preferences.setString("username", firebaseUser.displayName);
  //       await preferences.setString("profilepicture", firebaseUser.photoUrl);
  //     } else {
  //       await preferences.setString("id", documents[0]['id']);
  //       await preferences.setString("username", documents[0]['username']);
  //       await preferences.setString("id", documents[0]['profilepicture']);
  //     }
  //     Fluttertoast.showToast(msg: "Login was successful");
  //     setState(() {
  //       loading = false;
  //     });
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Homescreen()));
  //   } else {
  //     Fluttertoast.showToast(msg: "Login Failed");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userprovider>(context);
    Size size = MediaQuery.of(context).size;
    return Background(
      key: _key,
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
    );
  }
}
