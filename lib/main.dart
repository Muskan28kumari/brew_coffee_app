import 'package:coffeebrew/Screens/wrapper.dart';
import 'package:coffeebrew/models/user.dart';
import 'package:coffeebrew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD91qlofYlBpnyXk-SaVhDYkwbVWUccK5w",
      projectId: "brewcrew-327fc",
      storageBucket: "brewcrew-327fc.appspot.com",
      messagingSenderId: "439552852997",
      appId: "1:439552852997:android:b20955a35f43277b61c86c",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserClass?>.value(
      //the value we want provider to listen   // anything inside this is descendant widgets
      value: AuthService().user, //auth service value to be listen
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
