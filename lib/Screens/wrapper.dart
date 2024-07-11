//import 'package:coffeebrew/Screens/authenticate/authenticate.dart';
//import 'dart:js';

import 'package:coffeebrew/Screens/authenticate/authenticate.dart';
import 'package:coffeebrew/Screens/home/home.dart';
import 'package:coffeebrew/models/user.dart';
//import 'package:coffeebrew/Screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);
    print("first $user");
    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
