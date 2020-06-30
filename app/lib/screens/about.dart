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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/drabble_icon.png"),
                    height: 75.0,
                  ),
                  Image(
                    image: AssetImage("assets/images/drabble.png"),
                    height: 50.0,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Reach out to us!",
                    style: TextStyle(
                        fontSize: 35, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    "Dev by Jatin Karthik T",
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "jatinkarthikt@gmail.com",
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    "github.com/jatinkarthik-tripathy",
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    "Design by Yoha Ashuthosh K",
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "yoha21500@gmail.com",
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    "www.instagram.com/yoha21500",
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).primaryColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
