import 'dart:convert';
import 'package:DemoApp/home/Datainfo.dart';
import 'package:DemoApp/model/alldata.dart';
import 'package:DemoApp/model/createphotoAlbum.dart';
import 'package:DemoApp/model/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Datafetch extends StatefulWidget {
  final FetchAll fetchdata;
  Datafetch({this.fetchdata});
  @override
  _DatafetchState createState() => _DatafetchState();
}

class _DatafetchState extends State<Datafetch> {
  bool dataLoading = false;
  List<Photo> photodetails = List();

  _fetchalbumphotos() async {
    setState(() => dataLoading = true);
    final response = await http.get(
        "https://jsonplaceholder.typicode.com/photos?albumId=${widget.fetchdata.id}");
    if (response.statusCode == 200) {
      photodetails = (json.decode(response.body) as List)
          .map((data) => new Photo.fromJson(data))
          .toList();
      setState(() => dataLoading = false);
    } else {
      throw Exception('NetworK Error');
    }
  }

  List<int> elem = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  @override
  void initState() {
    _fetchalbumphotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.fetchdata.title}'),
        backgroundColor: Colors.black,
        elevation: 1.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
              onPressed: null)
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new FlatButton(
                color: Colors.white,
                onPressed: () {
                  if (elem[0] != 0) {
                    for (var i = 0; i < elem.length; i++) {
                      elem[i] -= 10;
                    }
                    _fetchalbumphotos();
                  }
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new FlatButton(
                color: Colors.white,
                onPressed: () {
                  if (elem[0] != 40) {
                    for (var i = 0; i < elem.length; i++) {
                      elem[i] += 10;
                    }
                    _fetchalbumphotos();
                    print(elem[0]);
                  }
                },
                child: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
      body: dataLoading
          ? new Center(
              child: CircularProgressIndicator(),
            )
          : new Container(
              padding: EdgeInsets.all(8.0),
              child: new ListView.builder(
                itemCount: elem.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    elevation: 2.0,
                    child: new FlatButton(
                      onPressed: () {
                        final data = AllData(
                          albumid: photodetails[elem[index]].albumid,
                          id: photodetails[elem[index]].id,
                          title: photodetails[elem[index]].title,
                          image: photodetails[elem[index]].image,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Datainfo(
                              data: data,
                            ),
                          ),
                        );
                      },
                      child: new Column(
                        children: <Widget>[
                          new Image.network(
                            photodetails[elem[index]].thumbnailUrl,
                            fit: BoxFit.cover,
                            width: 200.0,
                          ),
                          new Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              photodetails[elem[index]].title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
