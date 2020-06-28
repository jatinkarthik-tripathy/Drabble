import 'package:flutter/material.dart';
import 'package:app/screens/sidebar.dart';

class HomePage extends StatefulWidget {
  final String title;
  String name;
  String imageUrl;
  HomePage({
    Key key,
    this.title,
    this.name,
    this.imageUrl,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(
        name: name,
        imageUrl: imageUrl,
      );
}

class _HomePageState extends State<HomePage> {
  String name;
  String imageUrl;
  _HomePageState({
    this.name,
    this.imageUrl,
  });
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
                  onPressed: () => {},
                ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
