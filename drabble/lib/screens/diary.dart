import 'package:drabble/screens/addDiaryEntry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:drabble/screens/sidebar.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

class DiaryPage extends StatefulWidget {
  final String title;
  final String uid;
  final String name;
  final String imageUrl;
  DiaryPage({
    Key key,
    this.title,
    this.uid,
    this.name,
    this.imageUrl,
  }) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState(
        uid: uid,
        name: name,
        imageUrl: imageUrl,
      );
}

class _DiaryPageState extends State<DiaryPage> {
  String name;
  String imageUrl;
  String uid;
  final firestoreInstance = Firestore.instance;
  _DiaryPageState({
    this.uid,
    this.name,
    this.imageUrl,
  });

  var cryptor;
  var salt;
  var password;
  var generatedKey;

  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    cryptor = new PlatformStringCryptor();
    salt = "Ee/aHwc))8&actQ00sm/0A-=";
    password = uid;
    generatedKey = await cryptor.generateKeyFromPassword(password, salt);
  }

  _deleteAlert(BuildContext context, DocumentSnapshot doc) {
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
      onPressed: () {
        doc.reference.delete();
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
        "Do you want to permanently delete your Drabble?",
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

  _showPoem(BuildContext context, DocumentSnapshot doc) {
    Widget continueButton = FlatButton(
      color: Theme.of(context).backgroundColor,
      child: Text(
        "Close",
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
    Widget editButton = FlatButton(
      color: Theme.of(context).backgroundColor,
      child: Text(
        "Edit",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return DiaryEntry(
                uid: uid, name: name, imageUrl: imageUrl, doc: doc);
          },
        ));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Theme(
          data: Theme.of(context),
          child: Column(
            children: <Widget>[
              FutureBuilder<String>(
                future: _decrypt(doc["title"]),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  Container titleWidget;
                  if (snapshot.hasData) {
                    titleWidget = Container(
                      child: Text(
                        snapshot.data,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    );
                  } else {
                    titleWidget = Container(
                      child: Text(""),
                    );
                  }
                  return titleWidget;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    FutureBuilder<String>(
                      future: _decrypt(doc["body"]),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        Container bodyWidget;
                        if (snapshot.hasData) {
                          bodyWidget = Container(
                            child: SelectableText(
                              snapshot.data,
                              style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                            ),
                          );
                        } else {
                          bodyWidget = Container(
                            child: Text(""),
                          );
                        }
                        return bodyWidget;
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        editButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      child: alert,
    );
  }

  Future<String> _decrypt(encrypted) async {
    final decrypted = await cryptor.decrypt(encrypted, generatedKey);
    return decrypted;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        drawer: Sidebar(
          uid: uid,
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
                      return DiaryEntry(
                          uid: uid, name: name, imageUrl: imageUrl, doc: null);
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
            stream: firestoreInstance
                .collection(uid)
                .document("DiaryDoc")
                .collection("Diary")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                default:
                  return ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01,
                        ),
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.height * 0.01,
                            0,
                            MediaQuery.of(context).size.height * 0.01,
                            0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: FutureBuilder<String>(
                                    future: _decrypt(document["title"]),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      Container titleWidget;
                                      if (snapshot.hasData) {
                                        titleWidget = Container(
                                          child: Text(
                                            snapshot.data,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                            ),
                                          ),
                                        );
                                      } else {
                                        titleWidget = Container(
                                          child: Text(""),
                                        );
                                      }
                                      return titleWidget;
                                    },
                                  ),
                                ),
                                IconButton(
                                  iconSize: 20.0,
                                  icon: Icon(
                                    Icons.description,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    _showPoem(context, document);
                                  },
                                ),
                                IconButton(
                                  iconSize: 20.0,
                                  icon: Icon(
                                    Icons.delete,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    _deleteAlert(context, document);
                                  },
                                ),
                              ],
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
                          ],
                        ),
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
