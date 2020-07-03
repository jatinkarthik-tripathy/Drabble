import 'package:drabble/screens/home.dart';
import 'package:drabble/screens/sidebar.dart';
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
        backgroundColor: Color(0xFF2C3D63),
        drawer: Sidebar(
          name: name,
          imgURL: imageUrl,
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
          padding: EdgeInsets.all(30),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFF7F8F3),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.04, color: Color(0xFF2C3D63)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    "Dev by Jatin Karthik T",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025, color: Color(0xFF2C3D63)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "jatinkarthikt@gmail.com",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, color: Color(0xFF2C3D63)),
                  ),
                  Text(
                    "github.com/jatinkarthik-tripathy",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, color: Color(0xFF2C3D63)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    "Design by Yoha Ashuthosh K",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025, color: Color(0xFF2C3D63)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "yoha21500@gmail.com",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, color: Color(0xFF2C3D63)),
                  ),
                  Text(
                    "www.instagram.com/yoha21500",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, color: Color(0xFF2C3D63)),
                  ),
                ],
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color:  Color(0xFF2C3D63), width: 2)
                ),
                child: IconButton(
                  icon: Icon(Icons.chevron_left),
                  color: Color(0xFF2C3D63),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
