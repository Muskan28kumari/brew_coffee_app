import 'package:coffeebrew/models/user.dart';
import 'package:coffeebrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //final: its not gonna change in the future

  //created object            //property to get those
  final FirebaseAuth _auth = FirebaseAuth.instance; //for interaction
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //_auth is the unused variable for now , instance of class firebaseauth, access to all properties

  // create user obj based on firebaseuser
  UserClass _userFromFirebaseUser(User user) {
    return UserClass(uid: user.uid);
  }

  //auth change user stream
  Stream<UserClass> get user {
    return _auth
        .authStateChanges() //.map((event) => _userFromFirebaseUser);
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  //signin anonymously
  //asynchrounous so future will come
  Future signInAnon() async {
    try {
      //we need to wait for sometime so we use await
      UserCredential result =
          await _auth.signInAnonymously(); //this will result in authresult
      //AuthResult await _auth.signInAnonymously();    //this will result in authresult
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password); //built in firebase auth
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null; //can't signin or already register return null
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password); //built in firebase auth

      User? user = result.user; //new user back

      //create a new document for the user with uid of the user that comes back to us
      await DatabaseService(uid: user!.uid)
          .updateUserData('new crew member', '0', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null; //can't signin or already register return null
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
