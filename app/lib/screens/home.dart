import 'package:app/screens/addEntry.dart';
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

  void _showPoem() {}
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
              icon: Icon(Icons.add),
              color: Theme.of(context).backgroundColor,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Entry(
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
          child: StreamBuilder<QuerySnapshot>(
            stream: firestoreInstance.collection(uid).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(fontSize: 50),
                    ),
                  );
                default:
                  return ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.07,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              document["title"],
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.description,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: _showPoem,
                            )
                          ],
                        ),
                        // color: Theme.of(context).accentColor,
                      );
                    }).toList(),
                  );
              } // Switch
            }, // Builder
          ),
        ),
      ),
    );
  }
}

// CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               expandedHeight: 200.0,
//               floating: true,
//               snap: true,
//               pinned: true,
//               backgroundColor: Theme.of(context).primaryColor,
//               flexibleSpace: FlexibleSpaceBar(
//                 centerTitle: true,
//                 titlePadding: EdgeInsets.only(top: 10),
//                 title: Text(
//                   "Drabble",
//                   style: TextStyle(
//                     color: Theme.of(context).accentColor,
//                     fontSize: 35,
//                   ),
//                 ),
//               ),
//               elevation: 0,
//               centerTitle: true,
//               actions: <Widget>[
//                 // new IconButton(
//                 //   icon: Icon(Icons.search),
//                 //   color: Theme.of(context).backgroundColor,
//                 //   onPressed: () => {},
//                 // ),
//                 new IconButton(
//                     icon: Icon(Icons.add),
//                     color: Theme.of(context).backgroundColor,
//                     onPressed: _addEntry),
//               ],
//             ),
//             SliverFillRemaining(
//               child: FractionallySizedBox(
//                 heightFactor: 0.91,
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
//                   decoration: new BoxDecoration(
//                     color: Theme.of(context).backgroundColor,
//                     borderRadius: new BorderRadius.all(
//                       Radius.circular(40),
//                     ),
//                   ),
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: firestoreInstance.collection(uid).snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.hasError)
//                         return new Text('Error: ${snapshot.error}');
//                       switch (snapshot.connectionState) {
//                         case ConnectionState.waiting:
//                           return new Text('Loading...');
//                         default:
//                           return ListView(
//                             children: snapshot.data.documents
//                                 .map((DocumentSnapshot document) {
//                               return Container(
//                                 width: 200,
//                                 height: 20,
//                                 child: Text(document["title"]),
//                                 color: Theme.of(context).accentColor,
//                               );
//                             }).toList(),
//                           );
//                       } // Switch
//                     }, // Builder
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
