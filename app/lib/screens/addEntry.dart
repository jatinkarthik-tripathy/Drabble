import 'package:app/screens/home.dart';
import 'package:app/screens/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Entry extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String uid;
  final DocumentSnapshot doc;
  Entry({
    this.uid,
    this.name,
    this.imageUrl,
    this.doc,
  });

  @override
  _EntryState createState() =>
      _EntryState(uid: uid, name: name, imageUrl: imageUrl, doc: doc);
}

class _EntryState extends State<Entry> {
  final String name;
  final String imageUrl;
  final String uid;
  final DocumentSnapshot doc;
  TextEditingController _titleController;
  TextEditingController _bodyController;

  _EntryState({this.uid, this.name, this.imageUrl, this.doc});

  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    if (doc != null) {
      _titleController.text = doc["title"];
      _bodyController.text = doc["body"];
      doc.reference.delete();
    }
  }

  @override
  void dispose() {
    // other dispose methods
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _addEntry() {
    if (_titleController.text != "" && _bodyController.text != "") {
      Firestore.instance.collection(widget.uid).add({
        "title": _titleController.text,
        "body": _bodyController.text
      }).then((value) {});
    }
  }

  saveAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      color: Theme.of(context).backgroundColor,
      child: Text(
        "Done",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      onPressed: () {
        _addEntry();
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return HomePage(
                title: "Drabbles",
                uid: widget.uid,
                name: widget.name,
                imageUrl: widget.imageUrl,
              );
            },
          ),
          ModalRoute.withName('/'),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Saved",
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
      content: Text(
        "Your Drabble has been saved",
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      actions: <Widget>[
        continueButton,
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

  cancelAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      color: Theme.of(context).backgroundColor,
      child: Text(
        "Cancel",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
    );

    Widget noButton = FlatButton(
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
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return HomePage(
                title: "Drabbles",
                uid: widget.uid,
                name: widget.name,
                imageUrl: widget.imageUrl,
              );
            },
          ),
          ModalRoute.withName('/'),
        );
      },
    );
    Widget yesButton = FlatButton(
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
        _addEntry();
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return HomePage(
                title: "Drabbles",
                uid: widget.uid,
                name: widget.name,
                imageUrl: widget.imageUrl,
              );
            },
          ),
          ModalRoute.withName('/'),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Close Drabble",
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
      content: Text(
        "Do you want to save and close?",
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
        yesButton,
        noButton,
        cancelButton,
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        saveAlertDialog(context);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          drawer: Sidebar(
            uid: uid,
            name: widget.name,
            imgURL: widget.imageUrl,
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
                  cancelAlertDialog(context);
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
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: _titleController,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      border: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                      ),
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                      ),
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: _bodyController,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: "Let your thoughts run free ...",
                          hintStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text(
              "Save",
              style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w900),
            ),
            onPressed: () => saveAlertDialog(context),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
