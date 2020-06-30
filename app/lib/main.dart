import 'package:app/screens/auth.dart';
import 'package:app/screens/home.dart';
import 'package:app/util/theme_changer.dart';
import 'package:app/values/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    bool darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AnimatedSplash(
            imagePath: 'assets/images/drabble.png',
            home: MyApp(),
            duration: 3000,
            type: AnimatedSplashType.StaticDuration,
          ),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drabble',
      theme: themeNotifier.getTheme(),
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
    SharedPreferences.getInstance().then((prefs) {
    bool darkModeOn = prefs.getBool('darkMode') ?? true;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: (darkModeOn ? Color(0xFFF7F8F3) : Color(0xFF2C3D63)),
        statusBarIconBrightness: (darkModeOn ? Brightness.dark : Brightness.light),
      ),
    );
    });
    
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
