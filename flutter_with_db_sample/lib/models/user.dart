import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class CUser {
  static String userUid = '1';
  String firstName;
  String lastName;
  String mobile;
  String address;
  String email;
  String password;
  FirebaseAuth auth = FirebaseAuth.instance;
  CUser({this.firstName, this.lastName, this.mobile, this.address, this.email});

  //add pins to the db
  static Future<void> addUser({
    String firstName,
    String lastName,
    String mobile,
    String address,
    String email,
    String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = await FirebaseAuth.instance.currentUser;
    print(password);
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .set({
                'firstName': firstName,
                'lastName': lastName,
                'mobile': mobile,
                'address': address,
                'email': email,
                'password': password
              })
            });
  }

  static Future<String> loginUser({
    String email,
    String password,
  }) async {
    print(email);
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Welcome";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  static Future<void> updateUser({
    String firstName,
    String lastName,
    String mobile,
    String address,
  }) async {
    User user = await FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection("Users").doc(user.uid).update({
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'address': address
    });
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> deleteUser(String email, String password) async {
    // User user = await FirebaseAuth.instance.currentUser;
    // print(user.email);
    // user.delete();
    print(email);
    print(password);

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser
        .reauthenticateWithCredential(credential);
    try {
      await FirebaseAuth.instance.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }

    //FirebaseFirestore.instance.collection("Users").doc(user.uid).delete();
  }

  //Reset Password
  static Future<String> resetPassword({String email}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      return "Email sent";
    } catch (e) {
      return "Error occurred";
    }
  }
}
