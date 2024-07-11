import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeebrew/models/brew.dart';
import 'package:coffeebrew/models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  //function used twice once signup and another when want to update
  //get the reference to document and upadate the data
  Future updateUserData(String name, String sugars, int strength) async {
    //three parameters
    return await brewCollection.doc(uid).set({
      "name": name,
      "sugars": sugars,
      "strength": strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var data =
          doc.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
      return Brew(
          name: data['name'] ?? '',
          strength: data['strength'] ?? 0,
          sugars: data['sugars'] ?? '0');
    }).toList(); // Convert Iterable to List
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data =
        snapshot.data() as Map<String, dynamic>; // Explicit type annotation
    return UserData(
      uid: uid, // Assuming uid is defined elsewhere
      name: data['name'], // Cast to String
      sugars: data['sugars'], // Cast to String
      strength: data['strength'], // Cast to int
    );
  }

  //get brew stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
