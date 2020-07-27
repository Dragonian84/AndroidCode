import 'package:flutter/material.dart';
import 'package:DemoApp/model/alldata.dart';

class Datainfo extends StatelessWidget {
  final AllData data;
  Datainfo({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("${data.title}"),
        backgroundColor: Colors.black,
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Card(
                child: new Image.network(
                  "${data.image}",
                  fit: BoxFit.cover,
                ),
              ),
              new Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: ListView(
                    children: <Widget>[
                      new Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      ),
                      new Text(
                        "${data.title}",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      new Text(
                        "-------------------------------------",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      ),
                      new Text(
                        "Id ",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      ),
                      new Text(
                        "${data.id}",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      new Text(
                        "-------------------------------------",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      ),
                      new Text(
                        "Album ID",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      ),
                      new Text(
                        "${data.albumid}",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
