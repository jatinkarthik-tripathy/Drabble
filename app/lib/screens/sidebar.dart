import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: new BorderRadius.only(
          bottomRight: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.3,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      child: ListView(
        children: <Widget>[
          Text(
            "Home",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 35,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 15,
          ),
          // Text(
          //   "Dear Diary",
          //   style: TextStyle(
          //     color: Theme.of(context).primaryColor,
          //     fontSize: 35,
          //   ),
          //   textAlign: TextAlign.left,
          // ),
          // SizedBox(
          //   height: 15,
          // ),
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
          SizedBox(
            height: 15,
          ),
          Text(
            "Logout",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 35,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Developed by jajajaJKT",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "Designed by Yoha",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                color: Theme.of(context).primaryColor,
                onPressed: () => {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
