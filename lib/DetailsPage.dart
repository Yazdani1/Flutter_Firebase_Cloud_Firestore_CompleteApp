import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {

  DocumentSnapshot snapshot;

  DetailPage({this.snapshot});

  @override
  _DetailPageState createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Post Details"),
        backgroundColor: Colors.green,
      ),
      body: new ListView(
        children: <Widget>[

          new Container(
            margin: EdgeInsets.all(5.0),
            child: new Card(
              elevation: 9.0,
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: new Row(
                  children: <Widget>[

                    new CircleAvatar(
                      child: new Text(widget.snapshot.data["title"][0]),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    new SizedBox(width: 10.0,),
                    new Text(widget.snapshot.data["title"],
                      style: TextStyle(fontSize: 21.0,color: Colors.green),
                    )

                  ],
                ),
              ),

            ),
          ),//end
          new Container(
            margin: EdgeInsets.all(10.0),
            child: new ClipRRect(

              borderRadius: new BorderRadius.circular(10.0),
              child: new Image.network(widget.snapshot.data["url"],
              height: 200.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),

            ),
          )

        ],
      ),

    );
  }
}
