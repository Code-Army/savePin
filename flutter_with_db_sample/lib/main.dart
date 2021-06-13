import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_db_sample/pages/AddPin.dart';
import 'package:flutter_with_db_sample/pages/PinList.dart';
import 'package:flutter_with_db_sample/pages/PinListCategorized.dart';
import 'package:flutter_with_db_sample/pages/SplashScreen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PinApp());
}

class PinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/pinList': (context) => PinList(),
        '/addPin': (context) => AddPin(),
        '/categorizedList': (context) => PinListCategorized()

      },
    );
  }
}
