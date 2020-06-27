import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drabbles',
      theme: ThemeData(
        backgroundColor: Color(0xFF2C3D63),
        primaryColor: Color(0xFFAADCCA),
        accentColor: Color(0xFFF7F8F3),
        buttonColor: Color(0xFFFF6F5E),
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
              backgroundColor: Theme.of(context).accentColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Drabbles"),
              ),
            ),
            SliverFillRemaining(
              child: Container(
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
