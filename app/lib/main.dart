import 'package:app/screens/auth.dart';
import 'package:app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplash(
        imagePath: 'assets/images/drabble.png',
        home: MyApp(),
        duration: 3000,
        type: AnimatedSplashType.StaticDuration,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF7F8F3),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drabble',
      theme: ThemeData(
        backgroundColor: Color(0xFF2C3D63),
        primaryColor: Color(0xFFF7F8F3),
        accentColor: Color(0xFFFF6F5E),
      ),
      home: Root(),
    );
  }
}

enum AuthStatus { notLoggedIn, loggedIn }

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  String uid;
  String name;
  String imageUrl;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStart() async {
    String ret = "error";
    try {
      FirebaseUser _user = await _auth.currentUser();
      uid = _user.uid;
      name = _user.displayName;
      imageUrl = _user.photoUrl;
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }
      ret = "Success";
    } catch (e) {}
    return ret;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    String retString = await onStart();
    if (retString == "Success") {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = Auth();
        break;
      case AuthStatus.loggedIn:
        retVal = HomePage(
          title: "Drabble",
          uid: uid,
          name: name,
          imageUrl: imageUrl,
        );
        break;
      default:
    }
    return retVal;
  }
}
