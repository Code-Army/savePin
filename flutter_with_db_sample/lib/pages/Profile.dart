import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_db_sample/models/user.dart';
import 'package:flutter_with_db_sample/pages/Login.dart';
import 'package:flutter_with_db_sample/widgets/profile_button.dart';
import 'package:flutter_with_db_sample/widgets/profile_image.dart';

/**
 * class to related to update user to the db
 */
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  String password;
  final List<String> errors = [];
  String user = FirebaseAuth.instance.currentUser.email == null
      ? FirebaseAuth.instance.currentUser.phoneNumber
      : FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    final user = CUser();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PROFILE",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.lightBlue, Colors.indigo[900]])),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        elevation: 0,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfilImage(),
          const SizedBox(height: 24),
          FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return buildName("Loading", "Loading");
              return buildName(email, firstName);
            },
          ),
          FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return buildName("Loading", "Loading");
              return Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                  child: Card(
                    child: ListBody(
                      children: [
                        const SizedBox(height: 24),
                        Center(child: Btn()),
                        const SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                          child: buildFNameField(firstName),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                          child: buildLNameFormField(lastName),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                          child: buildPhoneNumberFormField(phoneNumber),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                          child: buildAddressFormField(address),
                        ),
                        const SizedBox(height: 14),
                        Center(child: BottomBtn()),
                        const SizedBox(height: 14),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    elevation: 20.0,
                    shadowColor: Colors.indigoAccent[500],
                  ));
            },
          ),
        ],
      ),
    );
  }

  Widget buildName(String email, String name) => Column(
        children: [
          Text(
            email,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            "Welcome $name",
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget Btn() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProfileButton(
              text: 'SignOut',
              onClicked: () {
                CUser().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              }),
          ProfileButton(
              text: 'Delete Account',
              onClicked: () {
                CUser.deleteUser(email, password);

                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  text: "Account Deleted successful!",
                );

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              })
        ],
      );

  Widget BottomBtn() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProfileButton(
              text: '             Update Details              ',
              onClicked: () async {
                CUser.updateUser(
                  firstName: firstName,
                  lastName: lastName,
                  mobile: phoneNumber,
                  address: address,
                );
              }),
        ],
      );

  TextFormField buildFNameField(String text) {
    return TextFormField(
      initialValue: text,
      onChanged: (newValue) => firstName = newValue,
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle_rounded),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildLNameFormField(String text) {
    return TextFormField(
      initialValue: text,
      onChanged: (value) => lastName = value,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your Last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle_rounded),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField(String text) {
    return TextFormField(
      initialValue: text,
      keyboardType: TextInputType.phone,
      onChanged: (newValue) => phoneNumber = newValue,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter Your Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.phone),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildAddressFormField(String text) {
    return TextFormField(
      initialValue: text,
      onChanged: (newValue) => address = newValue,
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter Your Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.location_on),
            ),
          ],
        ),
      ),
    );
  }

  _fetch() async {
    final User user = await FirebaseAuth.instance.currentUser;
    String fname1 = '';

    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get();
    print(user.uid);
    firstName = ds.get("firstName");
    lastName = ds.get("lastName");
    email = ds.get("email");
    phoneNumber = ds.get("mobile");
    address = ds.get("address");
    password = ds.get("password");
  }
}
