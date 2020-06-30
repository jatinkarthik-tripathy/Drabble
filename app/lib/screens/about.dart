import 'package:app/screens/home.dart';
import 'package:app/screens/sidebar.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final String uid;
  final String name;
  final String imageUrl;

  About({this.uid, this.name, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        drawer: Sidebar(
          name: name,
          imgURL: imageUrl,
        ),
        appBar: AppBar(
          title: Text(
            "Drabble",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: MediaQuery.of(context).size.height * 0.05,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cancel),
              color: Theme.of(context).backgroundColor,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage(
                        title: "Drabbles",
                        uid: uid,
                        name: name,
                        imageUrl: imageUrl,
                      );
                    },
                  ),
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
          padding: EdgeInsets.all(30),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Text("data"),
        ),

      ),
    );
  }
}
