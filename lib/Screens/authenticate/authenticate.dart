import 'package:coffeebrew/Screens/authenticate/register.dart';
import 'package:coffeebrew/Screens/authenticate/signin.dart';
//import 'package:coffeebrew/Screens/authenticate/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  //To check if signed up or not
  bool showSignUp = true;

  //create a function to
  void toggleView() {
    showSignUp = !showSignUp; //changes the value
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (showSignUp) {
      return SignIn(
          toggleView:
              toggleView); //passing the parameter to make sure signed up or not
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
