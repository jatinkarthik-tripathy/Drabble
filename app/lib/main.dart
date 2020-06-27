import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(
    MaterialApp(
      home: AnimatedSplash(
        imagePath: 'assets/images/drabble.png',
        home: MyApp(),
        duration: 3000,
        type: AnimatedSplashType.StaticDuration,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drabbles',
      theme: ThemeData(
        backgroundColor: Color(0xFF2C3D63),
        primaryColor: Color(0xFFF7F8F3),
        accentColor: Color(0xFFFF6F5E),
      ),
      home: MyHomePage(title: 'Drabbles'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: true,
              snap: true,
              pinned: true,
              backgroundColor: Theme.of(context).primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Drabble",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 35,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ),
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).backgroundColor,
                ),
                onPressed: null,
              ),
              actions: <Widget>[
                new IconButton(
                  icon: Icon(Icons.search),
                  color: Theme.of(context).backgroundColor,
                  onPressed: null,
                ),
              ],
            ),
            SliverFillRemaining(
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: new BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                  ),
                ),
                width: 300,
                height: 400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
