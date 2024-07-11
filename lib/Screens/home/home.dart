import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeebrew/Screens/authenticate/signin.dart';
import 'package:coffeebrew/Screens/home/brew_list.dart';
import 'package:coffeebrew/Screens/home/setting_form.dart';
import 'package:coffeebrew/models/brew.dart';
import 'package:coffeebrew/services/auth.dart';
import 'package:coffeebrew/services/database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  //to get the access of the auth service instance
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    //WHERE ARE WE IN THE WIDGET TREE

    //bottom popup is basically is botton sheet in flutter
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown.shade200,
        appBar: AppBar(
          backgroundColor: Colors.brown,
          //to keep the app bar flat we use elevation
          elevation: 0.0,
          title: Text('Home'),
          actions: [
            ElevatedButton.icon(
              label: Text('logout'),
              onPressed: () async {
                //to signout
                await _auth
                    .signOut(); // when this will be called the user will set to null
                print("logged out");
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              icon: Icon(Icons.logout),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  _showSettingPanel();
                },
                icon: Icon(Icons.settings),
                label: Text('Settings'))
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/image.png'),
              fit: BoxFit.cover,
            )),
            child: BrewList()),
      ),
    );
  }
}
