import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/sidebar.dart';

class HomePage extends StatefulWidget {
  final String title;
  final String uid;
  final String name;
  final String imageUrl;
  HomePage({
    Key key,
    this.title,
    this.uid,
    this.name,
    this.imageUrl,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(
        uid: uid,
        name: name,
        imageUrl: imageUrl,
      );
}

class _HomePageState extends State<HomePage> {
  String name;
  String imageUrl;
  String uid;
  final firestoreInstance = Firestore.instance;
  _HomePageState({
    this.uid,
    this.name,
    this.imageUrl,
  });

  void _addEntry() {
    firestoreInstance
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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: true,
              snap: true,
              pinned: true,
              backgroundColor: Theme.of(context).primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.only(top: 10),
                title: Text(
                  "Drabble",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 35,
                  ),
                ),
              ),
              elevation: 0,
              centerTitle: true,
              actions: <Widget>[
                // new IconButton(
                //   icon: Icon(Icons.search),
                //   color: Theme.of(context).backgroundColor,
                //   onPressed: () => {},
                // ),
                new IconButton(
                    icon: Icon(Icons.add),
                    color: Theme.of(context).backgroundColor,
                    onPressed: _addEntry),
              ],
            ),
            SliverFillRemaining(
              child: FractionallySizedBox(
                heightFactor: 0.91,
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  decoration: new BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: new BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: firestoreInstance.collection(uid).snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          return NotificationListener<ScrollUpdateNotification>(
                            child: ListView(
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                return Container(
                                  width: 200,
                                  height: 20,
                                  child: Text(document["title"]),
                                  color: Theme.of(context).accentColor,
                                );
                              }).toList(),
                            ),
                            onNotification: (notification) {
                               
                            },
                          );
                      } // Switch
                    }, // Builder
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
