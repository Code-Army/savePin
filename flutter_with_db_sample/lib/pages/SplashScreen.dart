import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/**
 * * class for splash screen
 * reference from
 * https://www.youtube.com/watch?v=PKQUzwZIZqg&list=WL&index=18
 * https://www.youtube.com/watch?v=YRlJmY2yxCY&list=WL&index=18
 */
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, '/pinList'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.lightBlue, Colors.indigo[900]])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset('assets/passwordSafety.png',
                    height: 100.0, width: 100.0),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'SavePin',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 40.0,
                      color: Colors.white),
                ),
                Text(
                  'Keep  your pins safe with you',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            SpinKitThreeBounce(color: Colors.white, size: 50.0)
          ],
        ),
      ),
    );
  }
}
