import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseApp/models/brew.dart';
import 'package:firebaseApp/models/user.dart';

class DatabaserServcie {
  final String uid;

  DatabaserServcie({this.uid});

  // collection reference (table)
  // here brews will be created as a collection in firebase console
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future userUpdateData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

// brew list from snapshot

List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((e) {
    return Brew(name: e.data['name'] ?? '',
    sugars: e.data['sugars'] ?? '0',
    strength: e.data['strength'] ?? 0
    );
  }).toList();
}


//userData from snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid: uid,
    name: snapshot.data['name'],
    sugars: snapshot.data['sugars'],
    strength: snapshot.data['strength']
  );

}

  // get brew stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot)
    ;
  }

  // get user doc stream
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}
