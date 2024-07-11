import 'package:coffeebrew/models/user.dart';
import 'package:coffeebrew/services/database.dart';
import 'package:coffeebrew/shared/constants.dart';
import 'package:coffeebrew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  SettingForm({super.key});

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);

    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          //snapshot reference, not related to firebase, flutter ka hai
          if (snapshot.hasData) {
            //class object
            UserData userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //text form field for the current name
                  TextFormField(
                    initialValue: userData.name,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Current Name'),
                    //to check whether the textfield is valid or not
                    validator: (val) =>
                        val!.isEmpty ? 'Enter correct current name' : null,

                    //if the form field changes
                    onChanged: (val) {
                      //val- whatever in the form written
                      //onChanged function run and gives the value that is currently inside the form field

                      setState(() {
                        _currentName = val; //settin the email to val
                      });
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ??
                        userData.sugars, //it is tha value of the dropdown value
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar, //tracks what value they select
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() {
                      _currentSugars = val;
                    }),
                  ),

                  //slider: to have control to move left to right
                  Slider(
                    min: 100.0, // strength minimum
                    max: 900.0, //maximum strength
                    activeColor: Colors.brown[
                        _currentStrength ?? userData.strength!], //slider color
                    inactiveColor: Colors.brown[_currentStrength ??
                        userData.strength!], //slider line color
                    divisions: 8,
                    value: (_currentStrength ?? userData.strength!).toDouble(),
                    onChanged: (val) => setState(() {
                      _currentStrength = val.round();
                    }),
                  ),

                  //for updating button is given
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name!,
                            _currentSugars ?? userData.sugars!,
                            _currentStrength ?? userData.strength!);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Update'),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
