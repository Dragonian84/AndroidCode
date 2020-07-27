import 'package:DemoApp/home/data.dart';
import 'package:flutter/material.dart';
import 'package:DemoApp/model/createalbum.dart';
import 'package:DemoApp/model/fetch_data.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AlbumPhoto extends StatefulWidget {
  @override
  _AlbumPhotoState createState() => _AlbumPhotoState();
}

class _AlbumPhotoState extends State<AlbumPhoto> {
  bool dataLoading = false;
  List<Album> album = List();
  _fetchAlbumdata() async {
    setState(() {
      dataLoading = true;
    });
    final response =
        await http.get("https://jsonplaceholder.typicode.com/albums");
    if (response.statusCode == 200) {
      album = (json.decode(response.body) as List)
          .map((data) => new Album.fromJson(data))
          .toList();
      setState(() {
        dataLoading = false;
      });
    } else {
      throw Exception(
          'Fail To load Data. There is some errors with the nework');
    }
  }

  @override
  void initState() {
    _fetchAlbumdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Album',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 1.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.white,
            onPressed: () => SystemNavigator.pop(),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 10.0,
        ),
        child: FlatButton(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              "Fetch Albums",
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPressed: _fetchAlbumdata,
        ),
      ),
      body: dataLoading
          ? new Center(
              child: CircularProgressIndicator(),
            )
          : new Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: new GridView.builder(
                itemCount: album.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return new FlatButton(
                    child: new Card(
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 3.0,
                        ),
                        child: new GridTile(
                          header: new Text(
                            album[index].albumid,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: Center(
                            child: new Text(
                              album[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          ),
                          //just for testing, will fill with image later
                        ),
                      ),
                    ),
                    onPressed: () {
                      final fetch = FetchAll(
                          id: album[index].albumid, title: album[index].title);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Datafetch(
                            fetchdata: fetch,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
