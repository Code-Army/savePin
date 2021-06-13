import 'package:cloud_firestore/cloud_firestore.dart';

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
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('pins').doc();

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

  //method to retrieve items from the db
  static Stream<QuerySnapshot> retrievePins() {
    CollectionReference pinCollection =
        _mainCollection.doc(userUid).collection('pins');
    return pinCollection.snapshots();
  }
}
