import 'package:app/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Sidebar extends StatelessWidget {
  final String name;
  final String imgURL;
  Sidebar({this.name, this.imgURL});
  final GoogleSignIn googleSignIn = GoogleSignIn();
  void signOutGoogle() async {
    await googleSignIn.signOut();
  }

  _logoutAlert(BuildContext context) {
    Widget yesBut = FlatButton(
      color: Theme.of(context).backgroundColor,
      child: Text("Yes"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      onPressed: () {
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
      child: Text("No"),
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
      content: Text("Do you want to log out?"),
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
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imgURL,
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
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 30,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text(
            "Home",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 35,
            ),
            textAlign: TextAlign.left,
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
            height: MediaQuery.of(context).size.height * 0.02,
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
            height: MediaQuery.of(context).size.height * 0.4,
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
                onPressed: () => {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
