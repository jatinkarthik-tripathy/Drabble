import 'package:app/screens/home.dart';
import 'package:app/screens/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Entry extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String uid;
  Entry({
    this.uid,
    this.name,
    this.imageUrl,
  });
  void _addEntry() {
    Firestore.instance
        .collection(uid)
        .add({"title": "first Drabble", "body": "testing"}).then((value) {
      print(value.documentID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                _addEntry();
                Navigator.of(context).push(
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
                );
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.87,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
