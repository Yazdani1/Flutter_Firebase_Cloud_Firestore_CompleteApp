import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_firebase_backendapp/DetailsPage.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  //Top post

  StreamSubscription<QuerySnapshot>subscription;
  List<DocumentSnapshot>snapshot;


  CollectionReference collectionReference=Firestore.instance.collection("TopPost");

  //For body post
  StreamSubscription<QuerySnapshot>sdSubscription;
  List<DocumentSnapshot>sdSnapshot;

  CollectionReference SdcollectionReference=Firestore.instance.collection("BodyPost");



  @override
  void initState() {

    subscription=collectionReference.snapshots().listen((datasnapshot){
      setState(() {
        snapshot=datasnapshot.documents;
      });
    });

    sdSubscription=SdcollectionReference.snapshots().listen((Sddatasnap){
      sdSnapshot=Sddatasnap.documents;
    });


    super.initState();
  }

  passData(DocumentSnapshot snap){
    Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>DetailPage(snapshot: snap,)));
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Firebase Backend App"),
        backgroundColor: Colors.purple,
        actions: <Widget>[

          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: ()=>debugPrint("Search")),
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: ()=>debugPrint("Add"))

        ],
      ),//appbar

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[

            new UserAccountsDrawerHeader(
                accountName: new Text("Code With Ydc"), 
                accountEmail: new Text("ydc@gmail.com"),
              decoration: new BoxDecoration(
                color: Colors.purple
              ),
            ),
            
            new ListTile(
              title: new Text("First Page"),
              leading: new Icon(Icons.search,color: Colors.green,),
            ),
            new ListTile(
              title: new Text("Second Page"),
              leading: new Icon(Icons.add,color: Colors.purple,),
            ),
            new ListTile(
              title: new Text("Third Page"),
              leading: new Icon(Icons.cake,color: Colors.redAccent,),
            ),
            new Divider(
              height: 10.0,
              color: Colors.black,
            ),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.close,color: Colors.red,),
              onTap: (){
                Navigator.of(context).pop();
              },
            )
            

          ],
        ),
      ),//end drawer
      body: new ListView(
        children: <Widget>[
          
          new Container(
            height: 200,
            child: new ListView.builder(
                itemCount: snapshot.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 10.0,
                    margin: EdgeInsets.all(5.0),
                    child: new Container(
                      margin: EdgeInsets.all(10.0),
                      child: new Column(
                        children: <Widget>[


                          new ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: new Image.network(snapshot[index].data["url"],
                              height: 120.0,
                              width: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          new SizedBox(height: 10.0,),
                          new Text(snapshot[index].data["title"],
                          style: TextStyle(fontSize: 19.0,color: Colors.purple),
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),//end first container

          new Container(
            height: MediaQuery.of(context).size.height,
            child: new ListView.builder(
                itemCount: sdSnapshot.length,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 7.0,
                    margin: EdgeInsets.all(10.0),
                    child: new Container(
                      padding: EdgeInsets.all(10.0),
                      child: new Column(
                        children: <Widget>[

                          new Row(
                            children: <Widget>[

                              new CircleAvatar(
                                child: new Text(sdSnapshot[index].data["title"][0]),
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.white,
                              ),
                              new SizedBox(width: 10.0,),
                              new InkWell(
                                child:   new Text(sdSnapshot[index].data["title"],
                                  style: TextStyle(fontSize: 20.0,color: Colors.purple),
                                ),
                                onTap: (){
                                  passData(sdSnapshot[index]);
                                },
                              )
                            

                            ],
                          ),
                          new SizedBox(height: 10.0,),
                          new Column(
                            children: <Widget>[

                              new ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: new Image.network(sdSnapshot[index].data["url"],
                                height: 150.0,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              new SizedBox(height: 10.0,),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  
                                  new Icon(Icons.thumb_up,color: Colors.purple,),
                                  new Icon(Icons.share,color: Colors.green,),
                                  new Icon(Icons.thumb_down,color: Colors.yellow,)
                                  
                                ],
                              ),


                            ],
                          )

                        ],
                      ),
                    ),
                  );
                }
            ),
          )



          
          
        ],
      ),
      
      

      
    );
  }
}

