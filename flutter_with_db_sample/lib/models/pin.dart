import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('pins');

/**
 * model class for Pin
 */
class Pin {
  static String userUid = '1';
  String type;
  String username;
  String pin;
  String name;

  Pin({this.type, this.pin, this.username, this.name});

  //add pins to the db
  static Future<void> addItem({
    String name,
    String pin,
    String type,
    String username,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = await FirebaseAuth.instance.currentUser;
    DocumentReference documentReference =
        _mainCollection.doc(user.uid).collection('pins').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'name': name,
      'pin': pin,
      'username': username,
      'type': type
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Pin is added successfully"))
        .catchError((e) => print(e));
  }

  static Future<void> updatePins({
    String name,
    String pin,
    String username,
    String docId,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = await FirebaseAuth.instance.currentUser;
    DocumentReference documentReferencer =
        _mainCollection.doc(user.uid).collection('pins').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'name': name,
      'pin': pin,
      'username': username,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Pin updated to database"))
        .catchError((e) => print(e));
  }

  //method to retrieve items from the db
  static Stream<QuerySnapshot> retrievePins() {
    CollectionReference pinCollection =
        _mainCollection.doc(userUid).collection('pins');
    return pinCollection.snapshots();
  }

  static Future<void> deletePin({
    String docId,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = await FirebaseAuth.instance.currentUser;
    DocumentReference documentReferencer =
        _mainCollection.doc(user.uid).collection('pins').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Pin Deleted from database'))
        .catchError((e) => print(e));
  }
}
