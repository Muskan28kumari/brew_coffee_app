import 'package:coffeebrew/services/auth.dart';
import 'package:coffeebrew/shared/constants.dart';
import 'package:coffeebrew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key, this.toggleView});
  final Function? toggleView; //? to ensure that the value can be null

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService(); //instance of auth service

  //formkey: ensuring them to write the answer
  final _formKey = GlobalKey<FormState>();

  //loading state
  bool loading = false;

  //textfield state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown.shade200,
            appBar: AppBar(
              backgroundColor: Colors.brown,
              title: Text('SignIn'),

              //to switch between the signin or register
              actions: [
                ElevatedButton.icon(
                  onPressed: () {
                    widget.toggleView!();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      //text form field for the email
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        //to check whether the textfield is valid or not
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an Email' : null,

                        //if the form field changes
                        onChanged: (val) {
                          //val- whatever in the form written
                          //onChanged function run and gives the value that is currently inside the form field

                          setState(() {
                            email = val; //settin the email to val
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //text form field for the password
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        //to validate the password
                        validator: (val) {
                          val!.length < 6
                              ? 'Enter the password 6+ character long'
                              : null;
                        },

                        //if the form field changes
                        obscureText:
                            true, //only able to see last letters for couple of seconds
                        onChanged: (val) {
                          //val- whatever in the form written
                          //onChanged function run and guves the value that is currently inside the form field
                          setState(() {
                            password = val; //setting the password to val
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            //used dynamic as we don't know what we will get as the result
                            dynamic result = await _auth
                                .signinWithEmailAndPassword(email, password);
                            if (result == null) {
                              //error here
                              setState(() {
                                error = 'could not sign in with credential';
                                loading = false;
                              });
                            }
                            //print('valid');
                            //to keep the track of email and password
                            /*print(email);
                    print(password);*/
                          }
                        },
                        child: Text(
                          'SignIn',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ],
                  )), /*ElevatedButton(
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              if (result == null) {
                print('error signin');
              } else {
                print('signedin');
                print(result.uid);
              }
            },
            child: Text('SignIn'))*/
            ),
          );
  }
}
