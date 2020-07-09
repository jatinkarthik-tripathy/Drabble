import 'package:drabble/screens/about.dart';
import 'package:drabble/screens/auth.dart';
import 'package:drabble/util/theme_changer.dart';
import 'package:drabble/values/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Sidebar extends StatefulWidget {
  final String uid;
  final String name;
  final String imgURL;
  Sidebar({this.uid, this.name, this.imgURL});

  @override
  _SidebarState createState() => _SidebarState(
        uid: uid,
        name: name,
        imgURL: imgURL,
      );
}

class _SidebarState extends State<Sidebar> {
  final String uid;
  final String name;
  final String imgURL;
  _SidebarState({this.uid, this.name, this.imgURL});
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: (value ? Color(0xFFF7F8F3) : Color(0xFF2C3D63)),
        statusBarIconBrightness: (value ? Brightness.dark : Brightness.light),
      ),
    );
    prefs.setBool('darkMode', value);
  }

  void signOutGoogle() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  _logoutAlert(BuildContext context) {
    Widget yesBut = FlatButton(
      color: Theme.of(context).backgroundColor,
      child: Text(
        "Yes",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      onPressed: () async {
        signOutGoogle();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return Auth();
        }), ModalRoute.withName('/'));
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget noBut = FlatButton(
      color: Theme.of(context).backgroundColor,
      child: Text(
        "No",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete Drabble",
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
      content: Text(
        "Do you want to log out?",
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      actions: [
        yesBut,
        noBut,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: new BorderRadius.only(
          bottomRight: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.imgURL,
                ),
                radius: 45,
                backgroundColor: Colors.transparent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Welcome,",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          InkWell(
            child: Text(
              "Home",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 35,
              ),
              textAlign: TextAlign.left,
            ),
            onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage(
                        title: "Drabbles",
                        uid: uid,
                        name: name,
                        imageUrl: imgURL,
                      );
                    },
                  ),
                  ModalRoute.withName('/'),
                );
              },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          // Text(
          //   "Dear Diary",
          //   style: TextStyle(
          //     color: Theme.of(context).primaryColor,
          //     fontSize: 35,
          //   ),
          //   textAlign: TextAlign.left,
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          Row(
            children: <Widget>[
              Text(
                "Dark Mode",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: MediaQuery.of(context).size.height * 0.025),
              ),
              Switch(
                value: _darkTheme,
                onChanged: (value) {
                  setState(() {
                    _darkTheme = value;
                  });
                  onThemeChanged(value, themeNotifier);
                },
                activeColor: Theme.of(context).accentColor,
                inactiveTrackColor: Theme.of(context).primaryColor,
                inactiveThumbColor: Theme.of(context).accentColor,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          SizedBox(
            height: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: new BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          InkWell(
            child: Text(
              "Logout",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 35,
              ),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              _logoutAlert(context);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Developed by jajajaJKT",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "Designed by Yoha",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return About(
                          uid: widget.uid,
                          name: widget.name,
                          imageUrl: widget.imgURL,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
