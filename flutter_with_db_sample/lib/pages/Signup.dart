import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_with_db_sample/models/user.dart';

/**
 * class to related to add user to the db
 */
class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email;
  String firstName;
  String lastName;
  String mobile;
  String address;
  String password;
  FirebaseAuth _auth = FirebaseAuth.instance;

  checkAuthentication() async {
    User user = _auth.currentUser;
    print(user);
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/pinList");
      }
    });
  }

  Widget getFields() {
    return Column(
      children: [
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
          child: buildFNameField(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
          child: buildLNameField(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
          child: buildMobileField(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
          child: buildAddressField(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
          child: buildEmailField(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
          child: buildPasswordField(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "REGISTER",
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
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Row(
              children: [],
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image(
                      image: AssetImage(
                        'assets/register.jpg',
                      ),
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
              child: Card(
                child: ListBody(
                  children: [
                    getFields(),
                    SizedBox(height: 20.0),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        height: 50.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.lightBlue[700],
                          elevation: 6.0,
                          child: GestureDetector(
                            onTap: () async {
                              await CUser.addUser(
                                firstName: firstName,
                                lastName: lastName,
                                mobile: mobile,
                                address: address,
                                email: email,
                                password: password,
                              );

                              Navigator.pushReplacementNamed(context, '/Login');

                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "User added successful!",
                              );
                            },
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        height: 50.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.lightBlue[700],
                          elevation: 6.0,
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.pushReplacementNamed(context, '/Login');
                            },
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildFNameField() {
    return TextFormField(
      onChanged: (newValue) => firstName = newValue,
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter Your First Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle_sharp),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildLNameField() {
    return TextFormField(
      onChanged: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter Your Last Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle_sharp),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildMobileField() {
    return TextFormField(
      onChanged: (newValue) => mobile = newValue,
      decoration: InputDecoration(
        labelText: "Mobile",
        hintText: "Enter Your Mobile",
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

  TextFormField buildAddressField() {
    return TextFormField(
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

  TextFormField buildEmailField() {
    return TextFormField(
      onChanged: (newValue) => email = newValue,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter Your Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.email),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      onChanged: (newValue) => password = newValue,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter Your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.lock),
            ),
          ],
        ),
      ),
    );
  }
}
