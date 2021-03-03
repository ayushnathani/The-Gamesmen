import 'package:flutter/material.dart';
import 'package:the_gamesman/Screens/Homescreen/homescreen.dart';
import 'package:the_gamesman/Screens/Login/login_screen.dart';
import 'package:the_gamesman/Screens/Mycart/Mycart.dart';
import 'package:the_gamesman/Screens/Productpage/ProductPage.dart';
import 'package:the_gamesman/Screens/Signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:the_gamesman/Screens/app_provider.dart';
import 'package:the_gamesman/Screens/userprovider.dart';

import 'package:the_gamesman/Screens/welcome/welcome_screen.dart';
import 'package:the_gamesman/constraints.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: Userprovider.initialize()),
      //ChangeNotifierProvider.value(value: Appprovider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Gamesman',
      routes: <String, WidgetBuilder>{
        './Screen1': (BuildContext context) => new Loginscreen(),
        './Screen2': (BuildContext context) => new Signupscreen(),
        './Screen3': (BuildContext context) => new WelcomeScreen(),
      },
      theme: ThemeData(
          primaryColor: kprimarycolor, scaffoldBackgroundColor: Colors.white),
      home: Screenscontroller(),
    );
  }
}

class Screenscontroller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userprovider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return CircularProgressIndicator();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Loginscreen();
      case Status.Authenticated:
        return Homescreen();

      default:
        return Loginscreen();
    }
  }
}
