import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_db_sample/models/user.dart';

class Reset extends StatefulWidget {
  final String email;
  final String password;
  final String documentId;

  Reset({
    this.email,
    this.password,
    this.documentId,
  });

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  String email;
  String password;

  Widget getFields() {
    return Column(
      children: [
        SizedBox(height: 30.0),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
          child: buildEmailField(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "RESET",
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
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image(
                      image: AssetImage(
                        'assets/login.jpg',
                      ),
                      height: 250.0,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
              child: Card(
                child: ListBody(
                  children: [
                    getFields(),
                    const SizedBox(
                      height: 10,
                    ),
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
                            onTap: () {
                              CUser.resetPassword(email: email).then((value) {
                                if (value == "Email sent") {
                                  Navigator.pushReplacementNamed(
                                      context, '/Login');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(value)));
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                'RESET',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 40.0),
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
                                'BACK',
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

  TextFormField buildEmailField() {
    return TextFormField(
      onChanged: (newValue) => email = newValue,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your Email",
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

  TextFormField buildPasswordField() {
    return TextFormField(
      onChanged: (newValue) => password = newValue,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your Password",
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
